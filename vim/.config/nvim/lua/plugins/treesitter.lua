local parsers = {
    "bash",
    "c",
    "cpp",
    "json",
    "lua",
    "markdown",
    "objc",
    "python",
    "regex",
    "swift",
    "vim",
    "yaml",
}

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(event)
                pcall(vim.treesitter.start, event.buf)
                vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
