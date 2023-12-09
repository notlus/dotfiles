require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        max_name_length = 25,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end,
        numbers = "none"
    }
}
 
