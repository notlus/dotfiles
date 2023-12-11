return {
	"sbdchd/neoformat",
	-- lazy = true
	config = function()
		-- Neoformat configuration for Swift
		vim.g.neoformat_swift_swiftformat = {
			exe = "swiftformat",
			args = { "--config", vim.fn.expand("$HOME/.swiftformat") },
			stdin = 1,
		}
	end,
}
