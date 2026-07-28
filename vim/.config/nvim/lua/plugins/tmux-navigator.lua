return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		local path = vim.fn.glob(vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"))
		if path == "" then
			vim.notify("vim-herdr-navigation editor/nvim.lua not found", vim.log.levels.WARN)
			return
		end
		dofile(path)
	end,
}
