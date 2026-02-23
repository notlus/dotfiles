local adapter = os.getenv("CODECOMPANION_ADAPTER") or "anthropic"

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
		{ "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New chat" },
		{ "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline assistant" },
		{ "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action palette" },
		{ "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to chat" },
		{ "<leader>af", "<cmd>CodeCompanion /fix<cr>", mode = "v", desc = "Fix selection" },
		{ "<leader>ax", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "Explain selection" },
		{ "<leader>at", "<cmd>CodeCompanion /tests<cr>", mode = "v", desc = "Generate tests" },
	},
	opts = {
		chat = {
			autoload = "default",
			enabled = true,
		},
		display = {
			action_palette = {
				provider = "snacks",
			},
		},
		interactions = {
			chat = {
				adapter = adapter,
			},
		},
		opts = {
			log_level = "DEBUG",
		},
		rules = {
			default = {
				description = "CodeCompanion",
				files = {
					".cursorrules",
					"AGENT.md",
					"AGENTS.md",
					"~/.config/dec-m-rules.md",
				},
				is_preset = true,
			},
		},
	},
}
