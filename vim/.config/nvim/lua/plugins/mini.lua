return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.bracketed").setup({
			comment = { suffix = "" },
		})
		require("mini.files").setup()
		require("mini.icons").setup()
		require("mini.sessions").setup({
			autoread = false, -- Don't auto-read sessions on startup
			-- autowrite = true,
			directory = "", -- Disable global sessions directory
			file = ".nvim.session", -- Use hidden local session files
		})

		local MiniSessions = require("mini.sessions")
		local session_file = MiniSessions.config.file

		-- Save local session
		vim.keymap.set("n", "<leader>qs", function()
			MiniSessions.write(session_file, { force = true })
			vim.notify("Session saved")
		end, { desc = "Save session" })

		-- Load session from local Session.vim
		vim.keymap.set("n", "<leader>ql", function()
			if vim.fn.filereadable(session_file) == 1 then
				MiniSessions.read(session_file, { force = true })
				vim.notify("Session loaded")
			else
				vim.notify("No " .. session_file .. " found")
			end
		end, { desc = "Load last session" })

		-- Delete local session
		vim.keymap.set("n", "<leader>qd", function()
			if vim.fn.filereadable(session_file) == 1 then
				MiniSessions.delete(session_file, { force = true })
				vim.notify("Session deleted")
			else
				vim.notify("No " .. session_file .. " to delete")
			end
		end, { desc = "Delete session" })

		-- Auto-save session on exit
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				if vim.fn.filereadable(session_file) == 1 then
					MiniSessions.write(session_file, { force = true })
				end
			end,
		})
	end,
}
