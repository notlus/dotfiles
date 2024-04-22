return {
	"folke/tokyonight.nvim",
	config = function()
		-- load the colorscheme here
		vim.cmd([[colorscheme tokyonight]])
		vim.g.tokyonight_style = "night" -- available: night, storm
		vim.g.tokyonight_enable_italic = 1
	end,
}
