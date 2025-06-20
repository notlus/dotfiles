return {
	cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
	filetypes = { "swift" },
	root_markers = { ".git", "buildServer.json", ".xcodeproj", ".xcworkspace", "Package.swift" },
	settings = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
}
