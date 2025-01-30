local keymap = vim.keymap

-- Key mappings

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use ESC to exit terminal mode
keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- Delete single character without copying to clipboard
keymap.set("n", "x", '"_x')
keymap.set("n", "X", '"_X')

-- Keep last yanked text when pasting
keymap.set("v", "p", '"_dP')

-- Create a new file
keymap.set("n", "<leader>n", ":enew<CR>", { desc = "[N]ew file" })

-- Navigate between split views
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-H>", "<C-W><C-H>")
keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Toggle MiniFiles
keymap.set("n", "<leader>m", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { silent = true, desc = "Toggle MiniFiles" })

-- Close all buffers
keymap.set("n", "<leader>ba", "<cmd>:bufdo bd<CR>", { desc = "Close all buffers" })

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

-- Reset the current hunk
keymap.set(
	"n",
	"hr",
	"<cmd>Gitsigns reset_hunk<CR>",
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

-- Xcode
keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<CR>", { desc = "Show All Xcodebuild Actions" })
keymap.set("n", "<leader>xf", "<cmd>XcodebuildProjectManager<CR>", { desc = "Show Project Manager Actions" })
keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<CR>", { desc = "Build Project" })
keymap.set("n", "<leader>xu", "<cmd>XcodebuildBuildForTesting<CR>", { desc = "Build Project for Testing" })
keymap.set("n", "<leader>xB", "<cmd>XcodebuildCleanBuild<CR>", { desc = "Clean build" })
keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<CR>", { desc = "Build and run" })
keymap.set("n", "<leader>xR", "<cmd>XcodebuildRun<CR>", { desc = "Build and run" })
keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<CR>", { desc = "Test" })
keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<CR>", { desc = "Run Selected Tests" })
keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<CR>", { desc = "Run This Test Class" })
keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<CR>", { desc = "Select Test Plan" })
keymap.set("n", "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<CR>", { desc = "Toggle Test Explorer" })
keymap.set("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<CR>", { desc = "Select scheme" })
keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<CR>", { desc = "Toggle Xcodebuild Logs" })
keymap.set("n", "<leader>x.", "<cmd>XcodebuildCancel<CR>", { desc = "Cancel build" })
keymap.set("n", "<leader>xC", "<cmd>XcodebuildSetup<CR>", { desc = "Show Configuration Wizard" })
keymap.set("n", "<leader>xo", function()
	vim.fn.system({
		"open",
		vim.fs.dirname(require("xcodebuild.project.config").settings.appPath),
	})
end, { desc = "Open project directory" })

keymap.set("n", "<leader>xd", function()
	vim.system({
		"open",
		vim.fs.dirname(require("xcodebuild.project.config").settings.appPath) .. "/../../../..",
	})
end, { desc = "Open derived data directory" })

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split window" })
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

-- LSP
keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
keymap.set("n", "<leader>ls", "<cmd>LspStart<CR>", { desc = "Start LSP" })
keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

-- LSP Saga
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
keymap.set("n", "<leader>co", "<cmd>Lspsaga outline<CR>", { desc = "[C]ode [O]utline" })
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]ename" })
keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "[P]eek [D]efinition" })
keymap.set("n", "K", "<cmd>Lspsaga hover_doc")
