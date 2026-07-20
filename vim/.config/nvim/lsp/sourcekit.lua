return {
	cmd = {
		"sourcekit-lsp",
		"-Xclangd",
		"--clang-tidy",
		"-Xclangd",
		"--background-index",
		"-Xclangd",
		"--offset-encoding=utf-8",
		"-Xclangd",
		"--query-driver=/Applications/Xcode*.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang*",
	},
	filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
	root_markers = {
		"buildServer.json",
		".xcodeproj",
		".xcworkspace",
		"Package.swift",
		"compile_commands.json",
		".clangd",
		".git",
	},
	get_language_id = function(_, ftype)
		local map = { objc = "objective-c", objcpp = "objective-cpp" }
		return map[ftype] or ftype
	end,
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
		textDocument = {
			diagnostic = {
				dynamicRegistration = true,
				relatedDocumentSupport = true,
			},
		},
	},
}
