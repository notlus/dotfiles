-- Status line
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- fancy icons
		"linrongbin16/lsp-progress.nvim", -- LSP loading progress
	},
	opts = {
		options = {
			theme = "tokyonight", -- lualine theme
		},
		sections = {
			lualine_c = {
				{
					-- Customize the filename part of lualine to be parent/filename
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 4, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					},
				},
			},
			lualine_x = {
				{ "' ' .. vim.g.xcodebuild_scheme", color = { fg = "#a6e3a1", bg = "#161622" } },
				{ "' ' .. vim.g.xcodebuild_config", color = { fg = "#ffa500", bg = "#161622" } },
				{ "'󰙨 ' .. vim.g.xcodebuild_last_status", color = { fg = "#e77273", bg = "#161622" } },
				{
					"vim.g.xcodebuild_platform == 'macOS' and '  macOS' or"
						.. " ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'",
					color = { fg = "#f9e2af", bg = "#161622" },
				},
			},
		},
	},
}
