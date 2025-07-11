vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

require("lazy").setup("plugins", {
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		change_detection = {
			enabled = true, -- automatically check for config file changes and reload the ui
			notify = false, -- turn off notifications whenever plugin changes are made
		},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	require("core.options"),
	require("core.keymaps"),
	require("lsp"),
})

-- Highlight configurations
vim.cmd([[highlight Normal guibg=none]])

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp", "swift" },
	callback = function()
		vim.opt_local.commentstring = "// %s"
	end,
})

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
