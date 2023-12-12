return {
	"wojciech-kulik/xcodebuild.nvim",
	config = function()
		require("xcodebuild").setup({
			-- Set to true to enable debug output
			debug = false,
		})

		ft = { "objc", "objc++", "swift", "c", "cpp" }
	end,
}
