return {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>sr",
			function()
				require("grug-far").open()
			end,
			desc = "Search and Replace",
			mode = "n",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Search and Replace word under cursor",
			mode = "n",
		},
		{
			"<leader>sr",
			function()
				require("grug-far").with_visual_selection()
			end,
			desc = "Search and Replace visual selection",
			mode = "v",
		},
		{
			"<leader>sf",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			desc = "Search and Replace in current file",
			mode = "n",
		},
		{
			"<leader>sF",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%:p:h") } })
			end,
			desc = "Search and Replace in current directory",
			mode = "n",
		},
	},
	config = function()
		require("grug-far").setup({
			headerMaxWidth = 80,
			keymaps = {
				replace = { n = "<localleader>r" },
				qflist = { n = "<localleader>q" },
				syncLocations = { n = "<localleader>s" },
				syncLine = { n = "<localleader>l" },
				close = { n = "<localleader>c" },
				historyOpen = { n = "<localleader>t" },
				historyAdd = { n = "<localleader>a" },
				refresh = { n = "<localleader>f" },
				openLocation = { n = "<localleader>o" },
				gotoLocation = { n = "<enter>" },
				pickHistoryEntry = { n = "<enter>" },
				abort = { n = "<localleader>b" },
				help = { n = "g?" },
			},
		})
	end,
}

