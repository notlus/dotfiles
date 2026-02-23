return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
        "--query-driver=/Applications/Xcode*.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang*",
	},
	root_markers = { ".clangd", "buildServer.json", ".xcodeproj", ".xcworkspace" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}
