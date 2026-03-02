return {
    "supermaven-inc/supermaven-nvim",
    enabled = true,
    event = "InsertEnter",
    config = function()
        require("supermaven-nvim").setup({
            log_level = "off",
            disable_inline_completions = false,
            disable_keymaps = true,
        })

        local suggestion = require("supermaven-nvim.completion_preview")
        vim.keymap.set("i", "<C-l>", suggestion.on_accept_suggestion, { desc = "Accept suggestion (Supermaven)" })
        vim.keymap.set("i", "<C-j>", suggestion.on_accept_suggestion_word, { desc = "Accept word (Supermaven)" })
        vim.keymap.set("i", "<C-]>", suggestion.on_dispose_inlay, { desc = "Clear suggestion (Supermaven)" })
    end,
}
