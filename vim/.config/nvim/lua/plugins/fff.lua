return {
    "dmtrKovalenko/fff.nvim",
    build = function()
        -- Downloads a prebuilt binary or falls back to cargo build.
        require("fff.download").download_or_build_binary()
    end,
    -- For NixOS:
    -- build = "nix run .#release",
    opts = {
        layout = {
            prompt_position = "top", -- default is "bottom"
        },
        -- Defaults are Up/C-p and Down/C-n; include them so Ctrl+K/J are additive.
        keymaps = {
            move_up = { "<Up>", "<C-p>", "<C-k>" },
            move_down = { "<Down>", "<C-n>", "<C-j>" },
        },
        debug = {
            enabled = true,
            show_scores = true,
        },
    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
        {
            "<leader><space>",
            function()
                require("fff").find_files()
            end,
            desc = "FFF: Find files",
        },
        {
            "<leader>/",
            function()
                require("fff").live_grep()
            end,
            desc = "FFF: Live grep",
        },
        {
            "<leader>fG",
            function()
                require("fff").find_in_git_root()
            end,
            desc = "FFF: Git files",
        },
        {
            "<leader>f.",
            function()
                -- Empty query: frecency-ranked files in the current project
                require("fff").find_files({ title = "Recent" })
            end,
            desc = "FFF: Recent (project)",
        },
        {
            "<leader>fR",
            function()
                local git_root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
                if git_root and git_root ~= "" and vim.v.shell_error == 0 then
                    require("fff").find_files_in_dir(git_root)
                else
                    require("fff").find_files({ title = "Recent" })
                end
            end,
            desc = "FFF: Recent (repo)",
        },
        {
            "<leader>fz",
            function()
                require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
            end,
            desc = "FFF: fuzzy+plain grep",
        },
        {
            "<leader>fw",
            function()
                require("fff").live_grep({ query = vim.fn.expand("<cword>") })
            end,
            desc = "FFF: [F]ind [W]ord",
        },
    },
}
