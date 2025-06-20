return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
	root_markers = { ".git", ".bashrc", ".bash_profile", ".zshrc" },
	settings = {
		bashIde = {
			-- Enable or disable the bashIde server
			enable = true,
		},
	},
}
