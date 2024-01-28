-- nvim-lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/nvim-cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	ft = { "c", "cpp", "objc", "objcpp", "dart", "kotlin", "lua", "swift" },

	config = function() -- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
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

				opts.desc = "Show definition for what is under cursor"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show implementation for what is under cursor"
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Add workspace folder"
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)

				opts.desc = "Remove workspace folder"
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)

				opts.desc = "List workspace folders"
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)

				opts.desc = "Show type definition for what is under cursor"
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)

				opts.desc = "Rename what is under cursor"
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show code actions for what is under cursor"
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Show references for what is under cursor"
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

				opts.desc = "Format the current buffer"
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})

		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		-- Add additional capabilities supported by nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local servers = { "clangd", "sourcekit", "dartls", "kotlin_language_server", "lua_ls" }
		local function setup_servers()
			for _, server in ipairs(servers) do
				capabilities = capabilities

				local opts = { noremap = true, silent = true }
				if server == "lua_ls" then
					opts = {
						settings = {
							Lua = {
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
								},
							},
						},
					}
				end
				if server == "sourcekit" then
					opts = {
						cmd = {
							"/usr/bin/sourcekit-lsp",
						},
						root_dir = function(filename)
							return util.root_pattern("buildServer.json")(filename)
								or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
								or util.find_git_ancestor(filename)
								or util.root_pattern("Package.swift")(filename)
						end,
					}
				end
				lspconfig[server].setup(opts)
			end
		end

		setup_servers()
	end,
}
