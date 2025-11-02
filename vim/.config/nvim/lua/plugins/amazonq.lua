return {
	{
		name = "amazonq",
		url = "https://github.com/awslabs/amazonq.nvim.git",
		cmd = "AmazonQ",
		inline_suggest = false,
		opts = {
			ssoStartUrl = "https://d-9067cfa456.awsapps.com/start",
			filetypes = {
				"amazonq",
				"bash",
				"python",
				"typescript",
				"javascript",
				"ruby",
				"sh",
				"sql",
				"c",
				"cpp",
				"go",
				"rust",
				"lua",
				"swift",
			},
			on_chat_open = function()
				vim.cmd([[
                    vertical botright split
                    vertical resize 80
                    set wrap
                    set breakindent
                    set nonumber
                    set norelativenumber
                    set nolist
                ]])
			end,
		},
	},
}
