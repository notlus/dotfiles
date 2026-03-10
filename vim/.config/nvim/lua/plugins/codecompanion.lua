local adapter = os.getenv("CODECOMPANION_ADAPTER") or "anthropic"

local function read_prompt_file(path, fallback)
    local f = io.open(vim.fn.expand(path), "r")
    if not f then
        return fallback
    end
    local content = f:read("*a")
    f:close()
    return content
end

local function git_diff(args)
    local handle = io.popen("git diff " .. args)
    if not handle then
        return nil
    end
    local diff = handle:read("*a")
    handle:close()
    return diff
end

return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ravitemer/codecompanion-history.nvim"
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
        { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", mode = "n", desc = "Browse chat history" },
    },
    opts = {
        adapters = {
            acp = {
                cursor = function()
                    return require("codecompanion.adapters.acp").extend("claude_code", {
                        name = "cursor",
                        formatted_name = "Cursor",
                        commands = {
                            default = { vim.fn.expand("~/.local/bin/cursor-agent"), "acp" },
                        },
                    })
                end,
            },
        },
        extensions = {
            history = {
                enabled = true,
                opts = {
                    keymap = "gh",
                    save_chat_keymap = "sc",
                    auto_save = true,
                    expiration_days = 0, -- 0 means chats never expire
                    picker = "snacks",
                    auto_generate_title = adapter ~= "acp",
                    title_generation_opts = {
                        adapter = nil,
                        model = nil,
                        refresh_every_n_prompts = 5,
                        max_refreshes = 3,
                    },
                    continue_last_chat = true,
                    delete_on_clearing_chat = false,
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                    enable_logging = false,
                },
            },
        },
        chat = {
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
            log_level = "WARN",
        },
        prompt_library = {
            ["Code Review"] = {
                interaction = "chat",
                description = "Review code",
                opts = {
                    alias = "review",
                    is_slash_cmd = true,
                },
                prompts = {
                    {
                        role = "user",
                        content = function()
                            return read_prompt_file(
                                "~/.config/code-review-prompt.md",
                                "Please review the selected code."
                            )
                        end,
                    },
                },
            },
            ["Commit Message"] = {
                interaction = "chat",
                description = "Generate a commit message for staged changes",
                opts = {
                    alias = "commit",
                    is_slash_cmd = true,
                },
                prompts = {
                    {
                        role = "user",
                        content = function()
                            local diff = git_diff("--cached")
                            if not diff then
                                return "Failed to execute git command."
                            end
                            if diff == "" then
                                return "No staged changes found. Please stage your changes with `git add` first."
                            end
                            return "Generate a commit message for these staged changes. Requirements:\n"
                                .. "- Be concise\n"
                                .. "- Use conventional commit format (e.g., feat:, fix:, refactor:, docs:)\n"
                                .. "- Use backticks around code and type names\n\n"
                                .. "```diff\n"
                                .. diff
                                .. "\n```"
                        end,
                    },
                },
            },
            ["Pull Request"] = {
                interaction = "chat",
                description = "Generate a pull request description",
                opts = {
                    alias = "pr",
                    is_slash_cmd = true,
                },
                prompts = {
                    {
                        role = "user",
                        content = function()
                            local base_branch = vim.g.pr_base_branch or "dev"
                            local prompt = read_prompt_file("~/.config/pull-request-prompt.md", "")
                            local diff = git_diff(base_branch .. "...HEAD")

                            if not diff then
                                return "Failed to execute git command."
                            end
                            if diff == "" then
                                return "No changes found compared to " .. base_branch .. " branch."
                            end
                            return prompt .. "\n\n```diff\n" .. diff .. "\n```"
                        end,
                    },
                },
            },
        },
        rules = {
            default = {
                description = "DEC-M",
                files = {
                    ".cursorrules",
                    "AGENT.md",
                    "AGENTS.md",
                    vim.fn.expand("~/.config/dec-m-rules.md"),
                },
                is_preset = true,
            },
            pr = {
                description = "Pull Request",
                files = {
                    vim.fn.expand("~/.kiro/steering/pull-request-template.md"),
                },
            },
        },
    },
}
