return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = true,
			suppress_dirs = { "~/Downloads", "~/Documents", "~/Desktop" },
			auto_save = true,
		})
	end,
}
