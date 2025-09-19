return {
	"supermaven-inc/supermaven-nvim",
    enabled = true,
	opts = {
		disable_inline_completions = true,
		-- disable_keymaps = true,
	},
	config = function()
		require("supermaven-nvim").setup({
			log_level = "off",
			disable_ghost_text = true,
			disable_inline_completions = true,
			completion = {
				enabled = false,
				-- Try to adjust ghost text appearance to be less intrusive
				ghost_text = {
					hl_group = "Comment", -- Make ghost text appear as comments
				},
			},
			integrations = {
				blink_cmp = {
					enabled = true,
				},
			},
		})
	end,
}
