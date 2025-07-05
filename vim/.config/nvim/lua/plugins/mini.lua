return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.bracketed").setup({
			comment = { suffix = "" },
		})
		require("mini.files").setup()
		require("mini.icons").setup()
		require("mini.sessions").setup({
			autoread = false, -- Whether to read latest session if Neovim started without file arguments
			autowrite = false, -- Disable autowrite, we'll handle it manually
			directory = vim.fn.stdpath("data") .. "/sessions/", -- Directory where global sessions are stored
			file = "", -- Disable local session files
		})

		-- Function to get project root (you can adjust the root patterns as needed)
		local function get_project_name()
			local project_directory = vim.fn.getcwd()
			return project_directory:gsub("/", "%%")
		end

		-- Session keymaps
		-- Quick save/load for current project
		vim.keymap.set("n", "<leader>sW", function()
			MiniSessions.write(get_project_name(), { force = true })
			vim.notify("Session saved for " .. vim.fn.getcwd())
		end, { desc = "Save project session" })

		vim.keymap.set("n", "<leader>sR", function()
			MiniSessions.read(get_project_name(), {})
		end, { desc = "Load project session" })

		-- Original keymaps for named sessions
		-- vim.keymap.set('n', '<leader>ss', function() MiniSessions.write(vim.fn.input('Session name: ')) end, { desc = 'Save named session' })
		-- vim.keymap.set('n', '<leader>sl', function() MiniSessions.select() end, { desc = 'Select session' })
		-- vim.keymap.set('n', '<leader>sd', function() MiniSessions.delete(vim.fn.input('Delete session: ')) end, { desc = 'Delete session' })

		-- Auto-save session on exit for current project
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				MiniSessions.write(get_project_name(), { force = true })
			end,
		})

		-- Auto-load session when entering Neovim without arguments
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 then
					vim.schedule(function()
						local ok = pcall(function()
							MiniSessions.read(get_project_name(), {})
						end)
						if ok then
							-- Force syntax highlighting and filetype detection for current buffer
							vim.cmd("filetype detect")
							vim.cmd("syntax enable")
							-- Also trigger BufRead autocmds which might set up highlighting
							vim.cmd("doautocmd BufRead")
						end
					end)
				end
			end,
		})
	end,
}
