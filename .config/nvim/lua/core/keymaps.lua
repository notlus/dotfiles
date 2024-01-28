vim.g.mapleader = " "
local keymap = vim.keymap

-- Key mappings

-- Use ESC to exit terminal mode
keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- Format buffer
keymap.set("n", "<leader>nf", ":Neoformat<CR>", { desc = "Format buffer" })

-- Navigate between buffers
-- keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "Next buffer" })
-- keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })

-- Navigate between split views
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-H>", "<C-W><C-H>")
keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Toggle nvim-tree with the leader key
keymap.set("n", "<leader>0", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

-- Telescope
vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, desc = "Open file browser" }
)
keymap.set("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<CR>', { desc = "Find files" })
keymap.set("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>', { desc = "Find word" })
keymap.set("n", "<leader>fr", ':lua require("telescope.builtin").oldfiles()<CR>', { desc = "Open recent files" })
keymap.set("n", "<leader>fs", ':lua require("telescope.builtin").grep_string()<CR>', { desc = "Find string" })
keymap.set("n", "<leader>b", ':lua require("telescope.builtin").buffers()<CR>', { desc = "Find buffers" })
keymap.set("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>', { desc = "Find help tags" })
keymap.set(
	"n",
	"<leader>lr",
	':lua require("telescope.builtin").repo.list({ bin = "/opt/homebrew/bin/fd" })<CR>',
	{ desc = "Find repos" }
)

-- Git
keymap.set("n", "<leader>gs", ":G<CR>", { desc = "Git status" })
keymap.set("n", "<leader>gl", ":G pull<CR>", { desc = "Git pull" })
keymap.set("n", "<leader>gb", ":Git branch", { desc = "Git branch" })
keymap.set("n", "<leader>gp", ":Git push", { desc = "Git push" })
-- keymap.set(
-- 	"n",
-- 	"<leader>gpsup",
-- 	":!Git push --set-upstream origin $(git_current_branch)<CR>",
-- 	{ desc = "Git push set upstream" }
-- )
-- keymap.set("n", "<leader>glog", ":Git log --oneline --decorate --graph<CR>", { desc = "Git log" })
-- keymap.set("n", "<leader>gco", ":Git checkout", { desc = "Git checkout" })
-- keymap.set("n", "<leader>gbr", ":Git branch --remote", { desc = "Git branch remote" })
keymap.set("n", "<leader>gd", ":Git checkout ${git_develop_branch}<CR>", { desc = "Git checkout develop" })
keymap.set("n", "<leader>gm", ":Git checkout ${git_main_branch}<CR>", { desc = "Git checkout main" })

-- Xcode
keymap.set("n", "<leader>xb", ":XcodebuildBuild<CR>", { desc = "Build" })
keymap.set("n", "<leader>xcb", ":XcodebuildCleanBuild<CR>", { desc = "Clean build" })
keymap.set("n", "<leader>xr", ":XcodebuildRun<CR>", { desc = "Build and run" })
keymap.set("n", "<leader>xta", ":XcodebuildTest<CR>", { desc = "Test" })
keymap.set("n", "<leader>xtf", ":XcodebuildTestFunc<CR>", { desc = "Test" })
keymap.set("n", "<leader>xss", ":XcodebuildSelectScheme<CR>", { desc = "Select scheme" })
keymap.set("n", "<leader>xp", ":XcodebuildPicker<CR>", { desc = "Picker" })
keymap.set("n", "<leader>xl", ":XcodebuildRunLast<CR>", { desc = "Run last" })
keymap.set("n", "<leader>xsc", ":XcodebuildSelectConfig<CR>", { desc = "Select configuration" })

keymap.set("n", "<leader>/", "gcc<CR>", { desc = "Comment line" })

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" })
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Make split window height shorter" })
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Make split windows height taller" })
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "Make split windows width bigger" })
keymap.set("n", "<leader>ss", "<C-w><5", { desc = "Make split windows width smaller" })

-- Quickfix
-- vim.api.nvim_set_keymap("n", "<leader>q", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix" })
-- vim.api.nvim_set_keymap("n", "<leader>w", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix" })
-- Keymap for opening the Quickfix list
vim.keymap.set("n", "<leader>qo", function()
	vim.cmd("copen")
end, { desc = "Open Quickfix list" })

-- Keymap for closing the Quickfix list
vim.keymap.set("n", "<leader>qc", function()
	vim.cmd("cclose")
end, { desc = "Close Quickfix list" })
