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
vim.keymap.set("n", "<space>l", function()
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

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, noremap = true, silent = true }

		opts.desc = "Show declaration for what is under cursor"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		-- Jump to the implementation of the word under your cursor.
		-- opts.desc = "Jump to implementation"
		-- vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, opts)

		vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" }, opts)
		vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outline<CR>", { desc = "[C]ode [O]utline" }, opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]ename" }, opts)
		vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "[P]eek [D]efinition" }, opts)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show documentation for what is under cursor"}, opts)

		opts.desc = "Add workspace folder"
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

		opts.desc = "Remove workspace folder"
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

		opts.desc = "List workspace folders"
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)

		opts.desc = "Rename what is under cursor"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Show code actions for what is under cursor"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		-- opts.desc = "Format the current buffer"
		-- vim.keymap.set("n", "<space>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts)
	end,
})

vim.lsp.enable({ "bashls", "clangd", "luals", "pyright", "sourcekit" })
