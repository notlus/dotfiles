return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					async = false,
					lsp_fallback = true,
					timeout_ms = 500,
				})
			end,
			mode = { "n", "v" },
			desc = "Format buffer or range",
		},
	},
	opts = {
		formatters_by_ft = {
			clang = { "clang_format" },
            json = { "jq" },
			lua = { "stylua" },
			swift = { "swiftformat_ext" },
		},
		log_level = vim.log.levels.ERROR,
		formatters = {
			swiftformat_ext = {
				command = "swiftformat",
				args = function()
					return {
						"--config",
						"~/.swiftformat",
						"--stdinpath",
						"$FILENAME",
					}
				end,
				range_args = function(self, ctx)
					return {
						"--config",
						"~/.swiftformat",
						"--linerange",
						ctx.range.start[1] .. "," .. ctx.range["end"][1],
					}
				end,
				stdin = true,
				condition = function(self, ctx)
					return vim.fs.basename(ctx.filename) ~= "README.md"
				end,
			},
		},
	},
}
