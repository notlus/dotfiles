vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and its plugins

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	require("lazy").setup("plugins", {
		change_detection = {
			enabled = true, -- automatically check for config file changes and reload the ui
			notify = false, -- turn off notifications whenever plugin changes are made
		},
	}),

	require("core.options"),
	require("core.keymaps"),
})

-- Highlight configurations
vim.cmd([[highlight ColorColumn ctermbg=lightgrey guibg=lightgrey]])
vim.cmd([[highlight Normal guibg=none]])

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp", "swift" },
	callback = function()
		vim.opt_local.commentstring = "// %s"
	end,
})
