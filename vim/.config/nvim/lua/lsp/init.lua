vim.lsp.config.bashls = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
	root_markers = { ".git", ".bashrc", ".bash_profile", ".zshrc" },
	settings = {
		bashIde = {
			-- Enable or disable the bashIde server
			enable = true,
		},
	},
}

vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},
	root_markers = { ".clangd", "buildServer.json", ".xcodeproj", ".xcworkspace" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}

vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- Sets the "root directory" to the parent directory of the file in the
	-- current buffer that contains either a ".luarc.json" or a
	-- ".luarc.jsonc" file. Files that share a root directory will reuse
	-- the connection to the same LSP server.
	-- root_markers = { ".luarc.json", ".luarc.jsonc" },
	-- Specific settings to send to the server. The schema for this is
	-- defined by the server. For example the schema for lua-language-server
	-- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
		},
		diagnostics = {
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
	},
}

vim.lsp.config.pyright = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt" },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}

vim.lsp.config["sourcekit"] = {
	cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
	filetypes = { "swift" },
	root_markers = { ".git", "buildServer.json", ".xcodeproj", ".xcworkspace", "Package.swift" },
	settings = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
}

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
	-- severity_sort = true,
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
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

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

		-- opts.desc = "Show documentation for what is under cursor"
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc")

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
