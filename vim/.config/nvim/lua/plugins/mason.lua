return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
        require("mason").setup({
            ui = {
                border = {
                    enabled = true,
                    chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    positions = { "top", "right", "bottom", "left" },
                },
            },
        })
    end,
}
