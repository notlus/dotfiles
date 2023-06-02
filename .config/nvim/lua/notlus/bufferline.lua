require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        numbers = function(opts)
            return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
    }
}
 
