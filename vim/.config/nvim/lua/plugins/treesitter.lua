return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
        highlight = {
            enable = true,
        },
        indent = { enable = true },
        auto_install = true,
        ensure_installed = {
            "lua",
            "markdown",
            "regex",
            "yaml",
        },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
    end,
}
