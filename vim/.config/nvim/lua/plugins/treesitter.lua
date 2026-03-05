return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        highlight = {
            enable = true,
        },
        indent = { enable = true },
        auto_install = true,
        ensure_installed = {
            "lua",
            "regex",
        },
    },
}
