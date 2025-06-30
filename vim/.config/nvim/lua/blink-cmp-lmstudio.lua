local M = {}

function M:new(opts)
	local instance = setmetatable({}, { __index = M })

	instance.config = vim.tbl_deep_extend("force", {
		host = "http://localhost:1234",
		model = "qwen/qwen2.5-coder-14b",
		max_tokens = 150,
		temperature = 0.2,
		timeout = 5000,
		max_context_lines = 50,
	}, opts or {})

	return instance
end

function M:get_trigger_characters()
	return { ".", ":", "(", "{", "[", " ", "\n" }
end

function M:enabled()
	local filetype = vim.bo.filetype
	-- Exclude non-code file types
	local excluded_filetypes = {
		"", -- empty filetype
		"help",
		"text",
		"markdown",
		"gitcommit",
		"gitrebase",
		"TelescopePrompt",
		"neo-tree",
		"lazy",
		"mason",
	}
	return not vim.tbl_contains(excluded_filetypes, filetype)
end

function M:get_context_before_cursor(bufnr, cursor_row, cursor_col)
	local start_row = math.max(0, cursor_row - self.config.max_context_lines)
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, cursor_row, false)

	-- Add the current line up to cursor
	local current_line = vim.api.nvim_buf_get_lines(bufnr, cursor_row, cursor_row + 1, false)[1] or ""
	if cursor_col > 0 then
		current_line = string.sub(current_line, 1, cursor_col)
	end
	table.insert(lines, current_line)

	-- Filter out test comments and noise
	local clean_lines = {}
	for _, line in ipairs(lines) do
		if
			not line:match("^%s*%-%- Try typing:")
			and not line:match("^%s*%-%- Test %d+:")
			and not line:match("^%s*%-%- Type here")
		then
			table.insert(clean_lines, line)
		end
	end

	return table.concat(clean_lines, "\n")
end

function M:extract_code_completion(text)
	-- Remove leading/trailing whitespace
	text = vim.trim(text)

	-- Stop at common comment markers or test patterns
	local stop_patterns = {
		"-- Try typing:",
		"-- Test %d+:",
		"-- Type here",
		"<%-%- ",
		"%-%->",
	}

	for _, pattern in ipairs(stop_patterns) do
		local pos = string.find(text, pattern)
		if pos then
			text = string.sub(text, 1, pos - 1)
			break
		end
	end

	-- Split into lines and clean up
	local lines = vim.split(text, "\n", { plain = true })

	-- Remove empty lines at the end
	for i = #lines, 1, -1 do
		if lines[i] == "" or lines[i]:match("^%s*$") then
			table.remove(lines, i)
		else
			break
		end
	end

	-- For function completions, we might want to keep multiple lines
	local result = table.concat(lines, "\n")

	-- But if it's getting too long or has too many lines, trim it
	if #lines > 3 then
		-- Take first 3 lines for multi-line completions
		result = table.concat({ lines[1], lines[2], lines[3] }, "\n")
	end

	return result
end

function M:resolve(item, callback)
	callback(item)
end

function M:get_completions(ctx, callback)
	local bufnr = ctx.bufnr
	local cursor_row = ctx.cursor[1] - 1
	local cursor_col = ctx.cursor[2]

	local context = self:get_context_before_cursor(bufnr, cursor_row, cursor_col)

	if context == "" or string.len(context) < 1 then
		callback({ is_incomplete_forward = false, items = {} })
		return
	end

	local current_line = vim.api.nvim_buf_get_lines(bufnr, cursor_row, cursor_row + 1, false)[1] or ""
	local before_cursor = string.sub(current_line, 1, cursor_col)

	local ok, curl = pcall(require, "plenary.curl")
	if not ok then
		callback({ is_incomplete_forward = false, items = {} })
		return
	end

	local response = curl.post(self.config.host .. "/v1/completions", {
		body = vim.json.encode({
			model = self.config.model,
			prompt = context,
			max_tokens = self.config.max_tokens,
			temperature = self.config.temperature,
			stop = { "\n\n", "```", "---", "--", "//", "#" },
		}),
		headers = {
			["Content-Type"] = "application/json",
		},
		timeout = self.config.timeout,
	})

	if response.status ~= 200 then
		callback({ is_incomplete_forward = false, items = {} })
		return
	end

	local ok_decode, json = pcall(vim.json.decode, response.body)
	if not ok_decode or not json.choices or #json.choices == 0 then
		callback({ is_incomplete_forward = false, items = {} })
		return
	end

	local completion_text = json.choices[1].text
	if not completion_text or completion_text == "" then
		callback({ is_incomplete_forward = false, items = {} })
		return
	end

	completion_text = self:extract_code_completion(completion_text)

	local items = {}

	-- Check if we're completing after a partial word
	local word_start = cursor_col
	local word_pattern = string.match(before_cursor, "([%w_]+)$")

	if word_pattern then
		-- We have a partial word, adjust the range to replace it
		word_start = cursor_col - #word_pattern
	end

	-- Clean up completion if it starts with = and we already have a variable name
	if word_pattern and completion_text:match("^%s*=") then
		-- Keep the variable name and add the completion
		completion_text = word_pattern .. " " .. completion_text
	end

	-- Create the completion item with textEdit
	local item = {
		label = completion_text,
		kind = vim.lsp.protocol.CompletionItemKind.Text,
		detail = "LM Studio (Qwen)",
		sortText = "00001", -- After LSP (00000) but before others
		textEdit = {
			newText = completion_text,
			range = {
				start = {
					line = ctx.cursor[1] - 1,
					character = word_start,
				},
				["end"] = {
					line = ctx.cursor[1] - 1,
					character = ctx.cursor[2],
				},
			},
		},
	}

	table.insert(items, item)

	callback({
		is_incomplete_forward = false,
		is_incomplete_backward = false,
		items = items,
	})
end

return M

