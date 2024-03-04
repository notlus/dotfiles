local keymap = vim.keymap

-- Key mappings

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use ESC to exit terminal mode
keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- Navigate between buffers
keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })

-- Navigate between split views
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-H>", "<C-W><C-H>")
keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Toggle nvim-tree with the leader key
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

-- Telescope
keymap.set(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, desc = "[F]ile [B]rowser" }
)
keymap.set("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<CR>', { desc = "[F]ind [F]iles" })
keymap.set("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>', { desc = "Find by [G]rep" })
keymap.set("n", "<leader>s.", ':lua require("telescope.builtin").oldfiles()<CR>', { desc = "Open recent files" })
keymap.set("n", "<leader>fw", ':lua require("telescope.builtin").grep_string()<CR>', { desc = "[F]ind [W]ord" })
keymap.set('n', '<leader>fd', ':lua require("telescope.builtin").diagnostics()<CR>', { desc = '[F]ind [D]iagnostics' })
keymap.set("n", "<leader>fr", ':lua require("telescope.builtin").resume()<CR>', { desc = "[Find] [R]esume" })
keymap.set("n", "<leader><leader>", ':lua require("telescope.builtin").buffers()<CR>', { desc = "Find buffers" })
keymap.set("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>', { desc = "[F]ind [H]elp" })

-- Search in the current buffer
keymap.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Git
-- Jump to the next Git change
keymap.set(
	"n",
	"]c",
	'<cmd>lua require"gitsigns.actions".next_hunk()<CR>',
	{ silent = true, desc = "Jump to the next Git change" }
)

-- Jump to the previous Git change
keymap.set(
	"n",
	"[c",
	'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>',
	{ silent = true, desc = "Jump to the previous Git change" }
)

-- Stage the current hunk
keymap.set("n", "hs", '<cmd>lua require"gitsigns".stage_hunk()<CR>', { silent = true, desc = "Stage the current hunk" })

-- Undo the last change in the current hunk
keymap.set(
	"n",
	"hu",
	'<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	{ silent = true, desc = "Undo the last change in the current hunk" }
)

-- Preview the changes in the current hunk
keymap.set(
	"n",
	"hp",
	'<cmd>lua require"gitsigns".preview_hunk()<CR>',
	{ silent = true, desc = "Preview the changes in the current hunk" }
)

-- Toggle the hunk under the cursor
keymap.set(
	"n",
	"h<space>",
	'<cmd>lua require"gitsigns".toggle_current_hunk()<CR>',
	{ silent = true, desc = "Toggle the hunk under the cursor" }
)

-- Blame the line under the cursor
keymap.set(
	"n",
	"bl",
	'<cmd>lua require"gitsigns".blame_line()<CR>',
	{ silent = true, desc = "Blame the line under the cursor" }
)

-- Show a diff of the current file
keymap.set(
	"n",
	"bd",
	'<cmd>lua require"gitsigns".preview_diff()<CR>',
	{ silent = true, desc = "Show a diff of the current file" }
)

keymap.set("n", "<leader>lg", ":LazyGit<CR>", { desc = "LazyGit" })

-- Xcode
keymap.set("n", "<leader>X", ":XcodebuildPicker<CR>", { desc = "Show All Xcodebuild Actions" })
keymap.set("n", "<leader>xf", ":XcodebuildProjectManager<CR>", { desc = "Show Project Manager Actions" })
keymap.set("n", "<leader>xb", ":XcodebuildBuild<CR>", { desc = "Build Project" })
keymap.set("n", "<leader>xB", ":XcodebuildCleanBuild<CR>", { desc = "Clean build" })
keymap.set("n", "<leader>xr", ":XcodebuildRun<CR>", { desc = "Build and run" })
keymap.set("n", "<leader>xt", ":XcodebuildTest<CR>", { desc = "Test" })
keymap.set("v", "<leader>xt", ":XcodebuildTestSelected<CR>", { desc = "Run Selected Tests" })
keymap.set("n", "<leader>xT", ":XcodebuildTestClass<CR>", { desc = "Run This Test Class" })
keymap.set("n", "<leader>xp", ":XcodebuildSelectTestPlan<CR>", { desc = "Select Test Plan" })
keymap.set("n", "<leader>xe", ":XcodebuildTestExplorerToggle<CR>", { desc = "Toggle Test Explorer" })
keymap.set("n", "<leader>xs", ":XcodebuildSelectScheme<CR>", { desc = "Select scheme" })
keymap.set("n", "<leader>xc", ":XcodebuildSelectConfig<CR>", { desc = "Select configuration" })
keymap.set("n", "<leader>xl", ":XcodebuildToggleLogs<CR>", { desc = "Toggle Xcodebuild Logs" })
keymap.set("n", "<leader>x.", ":XcodebuildCancel<CR>", { desc = "Cancel build" })
keymap.set("n", "<leader>xq", ":Telescope quickfix<CR>", { desc = "Show QuickFix List" })

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
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Shortcut for searching your neovim configuration files
keymap.set("n", "<leader>sn", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = " Search Neovim files" })

-- Restart LSP
keymap.set("n", "<leader>rl", ":LspRestart<CR>", { desc = "Restart LSP" })
