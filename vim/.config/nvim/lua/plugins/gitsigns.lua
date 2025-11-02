return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- signs = {
		-- 	add = { text = "+" },
		-- 	change = { text = "~" },
		-- 	delete = { text = "_" },
		-- },
		signs = {
			add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = {
				hl = "GitSignsChange",
				text = "~",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},

		-- Other gitsigns options
	},
	config = function()
		require("gitsigns").setup({
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, silent = true, desc = "Jump to the next Git change" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, silent = true, desc = "Jump to the previous Git change" })

				-- Actions
				map("n", "hs", gs.stage_hunk, { silent = true, desc = "Stage the current hunk" })
				map("n", "hr", gs.reset_hunk, { silent = true, desc = "Reset the current hunk" })
				map("v", "hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { silent = true, desc = "Stage selected lines" })
				map("v", "hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { silent = true, desc = "Reset selected lines" })

				-- New keymaps you requested
				map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage entire file" })
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })

				map("n", "hu", gs.undo_stage_hunk, { silent = true, desc = "Undo the last staged hunk" })
				map("n", "hp", gs.preview_hunk, { silent = true, desc = "Preview the changes in the current hunk" })
				map("n", "bl", function()
					gs.blame_line({ full = true })
				end, { silent = true, desc = "Blame the line under the cursor" })
				map("n", "bd", gs.diffthis, { silent = true, desc = "Show a diff of the current file" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, desc = "Select hunk" })
			end,
		})
	end,
}
