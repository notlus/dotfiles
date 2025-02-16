return {
	"supermaven-inc/supermaven-nvim",
	opts = {
		-- disable_inline_completions = true,
		--       disable_keymaps = true,
	},
	config = function()
		require("supermaven-nvim").setup({
			log_level = "off",
		})
	end,
}
