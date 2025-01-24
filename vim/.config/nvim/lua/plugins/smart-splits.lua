return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
    enabled = false,
	keys = {
		-- Moving between splits
		{
			"<C-h>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			mode = { "i", "n", "v" },
			desc = "Move to left window",
		},
		{
			"<C-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			mode = { "i", "n", "v" },
			desc = "Move to down window",
		},
		{
			"<C-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			mode = { "i", "n", "v" },
			desc = "Move to up window",
		},
		{
			"<C-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			mode = { "i", "n", "v" },
			desc = "Move to right window",
		},

		-- Resizing splits
		{
			"<C-Up>",
			function()
				require("smart-splits").resize_up()
			end,
			mode = { "i", "n", "v" },
			desc = "Resize up",
		},
		{
			"<C-Down>",
			function()
				require("smart-splits").resize_down()
			end,
			mode = { "i", "n", "v" },
			desc = "Resize down",
		},
		{
			"<C-Left>",
			function()
				require("smart-splits").resize_left()
			end,
			mode = { "i", "n", "v" },
			desc = "Resize left",
		},
		{
			"<C-Right>",
			function()
				require("smart-splits").resize_right()
			end,
			mode = { "i", "n", "v" },
			desc = "Resize right",
		},
	},
}
