local adapter = os.getenv("CODECOMPANION_ADAPTER") or "anthropic"
local config_home = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")

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

local function tagged_block(content, tag)
    local safe_tag = (tag or "content"):lower():gsub("[^a-z0-9_%-]", "_")
    return "<" .. safe_tag .. ">\n" .. content .. "\n</" .. safe_tag .. ">"
end

return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ravitemer/codecompanion-history.nvim",
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
        extensions = {
            history = {
                enabled = true,
                opts = {
                    keymap = "gh",
                    save_chat_keymap = "sc",
                    auto_save = true,
                    expiration_days = 0, -- 0 means chats never expire
                    picker = "snacks",
                    auto_generate_title = adapter ~= "kiro" and adapter ~= "cursor_cli",
                    title_generation_opts = {
                        adapter = nil,
                        model = nil,
                        refresh_every_n_prompts = 5,
                        max_refreshes = 3,
                    },
                    continue_last_chat = false,
                    delete_on_clearing_chat = false,
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history" .. vim.fn.getcwd(),
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
                adapter = {
                    name = adapter,
                    model = "gpt-5.3-codex",
                },
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
                                config_home .. "/code-review-prompt.md",
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
                    alias = "cm",
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
                                .. "- Use conventional commit format (e.g., feat:, fix:, refactor:, docs:)\n"
                                .. "- Be concise\n"
                                .. "- Keep subject line short\n"
                                .. "- Use backticks around code and type names\n"
                                .. "- Show commit message in a text block\n"
                                .. "- Ask permission before committing\n\n"
                                .. tagged_block(diff, "git_diff")
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
                            local prompt = read_prompt_file(config_home .. "/pull-request-prompt.md", "")
                            local diff = git_diff(base_branch .. "...HEAD")

                            if not diff then
                                return "Failed to execute git command."
                            end
                            if diff == "" then
                                return "No changes found compared to " .. base_branch .. " branch."
                            end
                            return prompt
                                .. "\n\nImportant: Return plain markdown only. Do not use fenced code blocks (no ``` blocks).\n\n"
                                .. tagged_block(diff, "git_diff")
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
                    config_home .. "/dec-m-rules.md",
                },
                is_preset = true,
            },
        },
    },
}
