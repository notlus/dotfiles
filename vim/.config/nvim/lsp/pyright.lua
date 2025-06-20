return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt" },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}
