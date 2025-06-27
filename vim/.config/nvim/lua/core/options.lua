-- General settings
local opt = vim.opt

-- Set the character encoding used in Neovim
opt.encoding = "utf8"

-- Turn off error beeping
opt.errorbells = false

-- Number of spaces that a tabstop counts for
opt.tabstop = 4

-- Number of spaces that a <Tab> counts for in edit mode
opt.softtabstop = 4

-- Number of spaces to use for each step of (auto)indent
opt.shiftwidth = 4

-- Expand tabs into spaces
opt.expandtab = true

-- Show line numbers on the left
opt.number = true

-- Show line numbers relative to the current cursor position
opt.relativenumber = true

-- Do not wrap long lines; they will continue off the screen to the right
opt.wrap = false

-- Do not create a swapfile for the buffer
opt.swapfile = false

-- Do not create backup files
opt.backup = false

-- Save undo history to an undo file
opt.undofile = true

-- Highlight matches as you type
opt.incsearch = true

-- Do not keep search results highlighted after search completion
opt.hlsearch = false

-- Allow switching buffers without saving them first
opt.hidden = true

-- Number of screen lines to keep above and below the cursor
opt.scrolloff = 10

-- Set command-line height to 2 lines, giving more room when viewing messages
opt.cmdheight = 2

-- Ignore case in search patterns
opt.ignorecase = true

-- Use smart case for searching: case-sensitive if search pattern contains uppercase letters, otherwise case-insensitive
opt.smartcase = true

-- Show the cursor position at all times
opt.ruler = true

-- Enable mouse support in all modes
opt.mouse = "a"

-- Always display the sign column
opt.signcolumn = "yes"

-- Use the system clipboard for all yank, delete, change, and put operations
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Show tabs at the top when there are at least two
opt.showtabline = 2

-- Highlight the screen line of the cursor
opt.cursorline = true

-- Insert spaces when <Tab> is pressed
opt.smarttab = true

-- Enable true colors support
opt.termguicolors = true

-- New split windows appear below the current one
opt.splitbelow = true

-- New split windows appear to the right of the current one
opt.splitright = true

-- Autocomplete menu behavior settings
opt.completeopt = "menu,menuone,noselect"

-- Set popup menu height
opt.pumheight = 10

-- Decrease the time before writing swap files and triggering plugins
opt.updatetime = 250

-- Length of time for a key sequence to complete in milliseconds
opt.timeoutlen = 300

-- Enable window title updates
opt.title = true

-- Preview substitutions live, as you type.
opt.inccommand = "split"

opt.virtualedit = "block"

opt.laststatus = 3

opt.confirm = true

opt.breakindent = true

opt.showmode = false
