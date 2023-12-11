return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		-- Setting up copilot
		vim.defer_fn(function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end, 100) -- Defer the setup to ensure the plugin is fully loaded; adjust the delay as needed

		-- Setting up copilot-cmp integration
		require("copilot_cmp").setup()
	end,
}
