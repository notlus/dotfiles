return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},
	root_markers = { ".clangd", "buildServer.json", ".xcodeproj", ".xcworkspace" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}
