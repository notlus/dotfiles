return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	dependencies = {
		"zbirenbaum/copilot-cmp",
	},
	config = function()
		-- Setting up copilot
		vim.defer_fn(function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = {
					-- Configure filetypes where Copilot should be active
					["*"] = true, -- Enable for all filetypes
				},
			})
		end, 100) -- Defer the setup to ensure the plugin is fully loaded; adjust the delay as needed

		-- Setting up copilot-cmp integration
		require("copilot_cmp").setup({
			method = "getCompletionsCycling", -- Get completions using cycling method
			formatters = {
				label = require("copilot_cmp.format").format_label_text,
				insert_text = require("copilot_cmp.format").format_insert_text,
				preview = require("copilot_cmp.format").deindent,
			},
		})
	end,
}
