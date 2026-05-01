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

local function extract_markdown_template(content)
    if not content then
        return nil
    end
    local body = content
    local template = body:match("```markdown%s*([\r\n].-)[\r\n]```")
    if template then
        return vim.trim(template)
    end
    return vim.trim(body)
end

local function remove_markdown_template_block(content)
    if not content then
        return ""
    end
    local without_template = content:gsub("```markdown%s*[\r\n].-[\r\n]```", "")
    return vim.trim(without_template)
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

local function fenced_block(content, language)
    local lang = language or ""
    return "```" .. lang .. "\n" .. content .. "\n```"
end

local function save_pr_markdown(chat, data)
    if not chat._save_pr_pending then
        return
    end
    chat._save_pr_pending = false
    local status = (data and data.status) or "unknown"

    local content = nil
    for i = #chat.messages, 1, -1 do
        local message = chat.messages[i]
        if
            (message.role == "llm" or message.role == "assistant")
            and type(message.content) == "string"
            and message.content ~= ""
        then
            content = message.content
            break
        end
    end

    if not content then
        vim.notify("No assistant response found to save as pr.md (status: " .. status .. ")", vim.log.levels.WARN)
        return
    end

    local path = vim.fs.joinpath(vim.fn.getcwd(), "pr.md")
    local file, err = io.open(path, "w")
    if not file then
        vim.notify("Failed to save pr.md: " .. (err or "unknown error"), vim.log.levels.ERROR)
        return
    end

    file:write(content)
    file:close()
    vim.notify("Saved PR draft to " .. path, vim.log.levels.INFO)
end

local function build_pull_request_message()
    local base_branch = vim.g.pr_base_branch or "dev"
    local prompt_text = read_prompt_file(config_home .. "/pr-message.md", "")
    local prompt_template = extract_markdown_template(prompt_text)
    local prompt_instructions = remove_markdown_template_block(prompt_text)
    local diff = git_diff(base_branch .. "...HEAD")

    if not prompt_template or prompt_template == "" then
        return "Missing markdown template in ~/.config/pr-message.md"
    end
    if not diff then
        return "Failed to execute git command."
    end
    if diff == "" then
        return "No changes found compared to " .. base_branch .. " branch."
    end

    return "Follow all instructions below and fill the markdown template using only the provided git diff. Do not inspect files or repo state. Return only the completed markdown body with no fenced code blocks.\n\n"
        .. prompt_instructions
        .. "\n\nMarkdown template:\n\n"
        .. prompt_template
        .. "\n\nUse only this diff as source material:\n\n"
        .. fenced_block(diff, "diff")
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
                slash_commands = {
                    ["pr"] = {
                        description = "Generate and save a pull request description",
                        callback = function(chat)
                            if not chat._pr_save_callback_registered then
                                chat:add_callback("on_completed", save_pr_markdown)
                                chat._pr_save_callback_registered = true
                            end
                            chat._save_pr_pending = true
                            chat:add_message({
                                role = "user",
                                content = build_pull_request_message(),
                            }, {
                                visible = false,
                            })
                            chat:submit({ auto_submit = true })
                        end,
                        opts = {
                            contains_code = false,
                        },
                    },
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
                            local prompt = read_prompt_file(
                                config_home .. "/commit-message.md",
                                "Generate a concise commit message for the staged changes."
                            )
                            local diff = git_diff("--cached")
                            if not diff then
                                return "Failed to execute git command."
                            end
                            if diff == "" then
                                return "No staged changes found. Please stage your changes with `git add` first."
                            end
                            return prompt
                                .. "\n\nUsing the staged diff below, generate a concise conventional commit message. Ask permission before committing.\n\n"
                                .. fenced_block(diff, "diff")
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
                    config_home .. "/swift-rules.md",
                },
                is_preset = true,
            },
        },
    },
}
