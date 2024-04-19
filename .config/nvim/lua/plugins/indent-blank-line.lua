return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		exclude = { filetypes = { "TestExplorer" } },
		scope = {
			show_start = false,
			show_end = false,
		},
	},
}
