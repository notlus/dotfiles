return {
	"saghen/blink.cmp",
	dependencies = {
		"onsails/lspkind-nvim",
		"nvim-tree/nvim-web-devicons",
		"Kaiser-Yang/blink-cmp-avante",
		"fang2hou/blink-copilot",
		"saghen/blink.compat",
		"nvim-lua/plenary.nvim",
		{
			"saghen/blink.compat",
			"giuxtaposition/blink-cmp-copilot",
			version = "*",
			lazy = true,
			opts = {},
		},
	},
	version = "1.*",
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = "super-tab" },
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				supermaven = {
					enabled = false,
					name = "supermaven",
					module = "blink.compat.source",
					score_offset = 100,
					async = true,
				},
				lsp = {
					score_offset = 2,
				},
				copilot = {
					enabled = true,
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
				avante = {
					enabled = false,
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {},
				},
				lmstudio = {
					enabled = false,
					name = "LLM",
					module = "blink-cmp-lmstudio",
					score_offset = 90,
					async = true,
					opts = {
						model = "qwen/qwen2.5-coder-14b",
						max_tokens = 300,
						temperature = 0.2,
					},
				},
			},
		},
		cmdline = {
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
		completion = {
			ghost_text = {
				enabled = true,
			},
			menu = {
				draw = {
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = "BlinkCmpKind" .. ctx.kind
									or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
						{ "source_name" },
					},
				},
				border = "single",
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "single",
				},
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = true,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
	},
	opts_extend = { "sources.default" },
}
