return {
	"ellisonleao/glow.nvim",
	config = function()
		-- Configuration settings for glow.nvim
		require("glow").setup({
			style = "dark",
			width = 120,
		})
	end,
	ft = { "markdown" },
	cmd = { "Glow" },
}
