vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "⚠",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
	},
})

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

-- Toggle virtual_lines for current line
local virtual_lines_enabled = false
vim.keymap.set("n", "<space>tv", function()
	virtual_lines_enabled = not virtual_lines_enabled
	if virtual_lines_enabled then
		vim.diagnostic.config({ virtual_lines = { current_line = true } })
	else
		vim.diagnostic.config({ virtual_lines = false })
	end
end, { desc = "Toggle diagnostic virtual lines" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local function buf_opts(desc)
			return vim.tbl_extend("force", { buffer = ev.buf, noremap = true, silent = true }, { desc = desc })
		end

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts("Show declaration for what is under cursor"))

		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", buf_opts("Code Action"))
		vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outline<CR>", buf_opts("[C]ode [O]utline"))
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", buf_opts("Rename"))
		vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", buf_opts("[P]eek [D]efinition"))
		vim.keymap.set("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.cmd("Lspsaga hover_doc")
			end
		end, buf_opts("Show documentation for what is under cursor"))

		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts("Add workspace folder"))
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts("Remove workspace folder"))
		vim.keymap.set("n", "<leader>wl", function()
			vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO)
		end, buf_opts("List workspace folders"))

		-- opts.desc = "Format the current buffer"
		-- vim.keymap.set("n", "<space>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts)
	end,
})

vim.lsp.enable({ "bashls", "luals", "pyright", "sourcekit" })
