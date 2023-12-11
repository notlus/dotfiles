return {
	"zbirenbaum/copilot-cmp",
	after = "copilot.lua", -- Load this after the main Copilot plugin is loaded
	config = function()
		-- Setting up copilot-cmp integration with native cmp
		require("copilot_cmp").setup()
	end,
}
