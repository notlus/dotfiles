return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.bracketed").setup()
		require("mini.files").setup()
		require("mini.icons").setup()
        require("mini.sessions").setup()
	end,
}
