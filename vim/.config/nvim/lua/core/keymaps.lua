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


-- Xcode
keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<CR>", { desc = "Show All Xcodebuild Actions" })
keymap.set("n", "<leader>xm", "<cmd>XcodebuildProjectManager<CR>", { desc = "Show Project Manager Actions" })
keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<CR>", { desc = "Build Project" })
keymap.set("n", "<leader>xu", "<cmd>XcodebuildBuildForTesting<CR>", { desc = "Build for Testing" })
keymap.set("n", "<leader>xB", "<cmd>XcodebuildCleanBuild<CR>", { desc = "Clean build" })
keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<CR>", { desc = "Build and run" })
keymap.set("n", "<leader>xR", "<cmd>XcodebuildRun<CR>", { desc = "Run without building" })
keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<CR>", { desc = "Test" })
keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<CR>", { desc = "Run Selected Tests" })
keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<CR>", { desc = "Run This Test Class" })
keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<CR>", { desc = "Select Test Plan" })
keymap.set("n", "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<CR>", { desc = "Toggle Test Explorer" })
keymap.set("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<CR>", { desc = "Select scheme" })
keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<CR>", { desc = "Toggle Xcodebuild Logs" })
keymap.set("n", "<leader>x.", "<cmd>XcodebuildCancel<CR>", { desc = "Cancel build" })
keymap.set("n", "<leader>xC", "<cmd>XcodebuildSetup<CR>", { desc = "Show Configuration Wizard" })
keymap.set("n", "<leader>xf", "<cmd>XcodebuildQuickfixLine<CR>", { desc = "Quickfix Line" })
keymap.set("n", "<leader>xa", "<cmd>XcodebuildCodeActions<CR>", { desc = "Show code actions" })
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

-- Copilot partial completion keymaps
keymap.set("i", "<C-l>", function()
	require("copilot.suggestion").accept()
end, { silent = true, desc = "Accept Copilot suggestion" })

keymap.set("i", "<C-j>", function()
	require("copilot.suggestion").accept_word()
end, { silent = true, desc = "Accept Copilot word" })

keymap.set("i", "<C-k>", function()
	require("copilot.suggestion").accept_line()
end, { silent = true, desc = "Accept Copilot line" })
