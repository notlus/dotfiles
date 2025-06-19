return {
	"MagicDuck/grug-far.nvim",
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

		-- Global keymaps for opening grug-far
		vim.keymap.set("n", "<leader>sr", function()
			require("grug-far").open()
		end, { desc = "Search and Replace" })

		vim.keymap.set("n", "<leader>sw", function()
			require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
		end, { desc = "Search and Replace word under cursor" })

		vim.keymap.set("v", "<leader>sr", function()
			require("grug-far").with_visual_selection()
		end, { desc = "Search and Replace visual selection" })

		vim.keymap.set("n", "<leader>sf", function()
			require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
		end, { desc = "Search and Replace in current file" })

		vim.keymap.set("n", "<leader>sF", function()
			local current_dir = vim.fn.expand("%:p:h")
			require("grug-far").open({ prefills = { paths = current_dir } })
		end, { desc = "Search and Replace in current directory" })
	end,
}