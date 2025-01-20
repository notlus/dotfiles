return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bufdelete = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
		},
		gitbrowse = {
			enabled = true,
		},
		indent = {
			enabled = true,
		},
		lazygit = {
			enabled = true,
		},
		notifier = {
			enabled = true,
		},
		picker = {
			enabled = true,
			formatters = {
				file = {
					filename_first = true,
				},
			},
			sources = {
				files = {
					hidden = true,
				},
				grep = {
					hidden = true,
				},
			},
		},
		scratch = {
			enabled = true,
		},
		statuscolumn = {
			enabled = true,
		},
		terminal = {
			enabled = true,
		},
	},
	-- stylua: ignore
	keys = {
        -- Files
	    { "<leader>ff", function() Snacks.picker.files() end, desc = "[F]ind [F]iles" },
	    { "<leader>fG", function() Snacks.picker.git_files() end, desc = "[F]ind by [G]it" },
	    { "<leader>f.", function() Snacks.picker.recent() end, desc = "Recent" },
	    { "<leader>fg", function() Snacks.picker.grep() end, desc = "[F]ind by [G]rep" },
	    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "[F]ind [W]ord", mode = { "n", "x" } },

        -- Search
	    { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },
	    { "<leader>/", function() Snacks.picker.lines() end, desc = "Search in current buffer" },
        { "<leader>fr", function() Snacks.picker.resume() end, desc = "[F]ind [R]esume" },
        { "<leader>fh", function() Snacks.picker.help() end, desc = "[F]ind [H]elp" },
        { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "[F]ind [D]iagnostics" },

        -- LSP
	    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "[D]ocument Symbols" },
	    { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[W]orkspace Symbols" },
	    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
	    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
	    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
	    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },

        -- Git
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },

        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>h",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
	},
}
