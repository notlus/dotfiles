return {
	"hrsh7th/nvim-cmp", -- The main cmp plugin
	event = "InsertEnter", -- Load this plugin when entering insert mode
	dependencies = {
		"L3MON4D3/LuaSnip", -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- Cmp source for LuaSnip
		"hrsh7th/cmp-nvim-lsp", -- Cmp source for LSP
		"rafamadriz/friendly-snippets", -- Preconfigured snippets
		"hrsh7th/cmp-buffer", -- Buffer completions
		"hrsh7th/cmp-path", -- Path completions
		"hrsh7th/cmp-cmdline", -- Command line completions
	},
	config = function()
		local luasnip = require("luasnip") -- Snippet engine
		local cmp = require("cmp") -- The autocomplete component

		local kind_icons = {
			-- Icons for different kinds of completions
			Text = "",
			Method = "m",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		-- Function to check if there are words before cursor
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- Configuring nvim-cmp
		cmp.setup({
			snippet = {
				expand = function(args)
					-- Expanding the snippets using LuaSnip
					luasnip.lsp_expand(args.body)
				end,
			},
			-- mapping = cmp.mapping.preset.insert({
			mapping = {
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = {
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				},
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				["<TAB>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						-- This holds the display name for all possible sources
						supermaven = "[SM]",
						copilot = "[CP]",
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
						-- Add or modify source names as necessary
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				-- Add more sources if needed
			}),
			window = {
				completion = {
					border = "rounded",
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
				},
			},
			experimental = {
				ghost_text = false, -- This shows a preview of the selected item in the background
				native_menu = false, -- This disables the native completion menu in favor of nvim-cmp's
			},
		})

		-- Specify settings for when using nvim-cmp with the command line
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
