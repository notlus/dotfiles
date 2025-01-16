return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		previewers = {
			bat = {
				cmd = "bat",
				args = "--color=always --style=numbers,changes",
				theme = "tokyonight_moon",
			},
		},
		files = {
			prompt = "Files> ",
			previewer = "bat",
			formatter = "path.filename_first",
		},
		grep = {
			prompt = "Find> ",
			previewer = "bat",
			formatter = "path.filename_first",
		},
		buffers = {
			prompt = "Buffers> ",
			previewer = "bat",
			formatter = "path.filename_first",
		},
	},
}
