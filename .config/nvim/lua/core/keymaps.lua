vim.g.mapleader = " "
local keymap = vim.keymap

-- Key mappings

-- Use ESC to exit terminal mode
keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- Format buffer
keymap.set("n", "<leader>nf", ":Neoformat<CR>")

-- Navigate between buffers
keymap.set("n", "<TAB>", ":bnext<CR>")
keymap.set("n", "<S-TAB>", ":bprevious<CR>")

-- Navigate between split views
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-H>", "<C-W><C-H>")
keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Toggle nvim-tree with the leader key
keymap.set("n", "<leader>0", ":NvimTreeToggle<CR>")

-- Telescope
vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)
keymap.set("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<CR>')
keymap.set("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>')
keymap.set("n", "<leader>fs", ':lua require("telescope.builtin").grep_string()<CR>')
keymap.set("n", "<leader>b", ':lua require("telescope.builtin").buffers()<CR>')
keymap.set("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>')
keymap.set("n", "<leader>repos", ':lua require("telescope.builtin").repo.list({ bin = "/opt/homebrew/bin/fd" })<CR>')

-- Git
keymap.set("n", "<leader>gst", ":G<CR>")
keymap.set("n", "<leader>gl", ":G pull<CR>")
keymap.set("n", "<leader>gco", ":Git checkout")
keymap.set("n", "<leader>gb", ":Git branch")
keymap.set("n", "<leader>gbr", ":Git branch --remote")
keymap.set("n", "<leader>gp", ":Git push")
keymap.set("n", "<leader>gpsup", ":!Git push --set-upstream origin $(git_current_branch)<CR>")
keymap.set("n", "<leader>glog", ":Git log --oneline --decorate --graph<CR>")
keymap.set("n", "<leader>gcd", ":Git checkout ${git_develop_branch}<CR>")
keymap.set("n", "<leader>gcm", ":Git checkout ${git_main_branch}<CR>")

-- Xcode
keymap.set("n", "<leader>xb", ":XcodebuildBuild<CR>")
keymap.set("n", "<leader>xcb", ":XcodebuildCleanBuild<CR>")
keymap.set("n", "<leader>xbr", ":XcodebuildRun<CR>")
keymap.set("n", "<leader>xt", ":XcodebuildTest<CR>")
keymap.set("n", "<leader>xs", ":XcodebuildSelectScheme<CR>")
keymap.set("n", "<leader>xp", ":XcodebuildPicker<CR>")
keymap.set("n", "<leader>xl", ":XcodebuildRunLast<CR>")
keymap.set("n", "<leader>xc", ":XcodebuildSelectConfig<CR>")
keymap.set("n", "<leader>xtp", ":XcodebuildSelectTestPlan<CR>")

keymap.set("n", "<leader>/", ":!gcc %<CR>")

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
keymap.set("n", "<leader>ss", "<C-w><5") -- make split windows width smaller

-- Quickfix
vim.api.nvim_set_keymap("n", "<leader>q", ":copen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":cclose<CR>", { noremap = true, silent = true })
