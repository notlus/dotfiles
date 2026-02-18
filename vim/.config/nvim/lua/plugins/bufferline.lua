return {
    "akinsho/bufferline.nvim",
    event = "BufWinEnter",
    opts = {
        options = {
            show_buffer_close_icons = false,
            show_close_icon = false,
            max_name_length = 25,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or ""
                return " " .. icon .. count
            end,
            numbers = "none",
            custom_filter = function(buf_number)
                local excluded_filetypes = { "TestExplorer", "grug-far", "xcodebuild.log", "codecompanion" }
                local buf_ft = vim.bo[buf_number].filetype
                local buf_name = vim.api.nvim_buf_get_name(buf_number)
                for _, ft in ipairs(excluded_filetypes) do
                    if buf_ft == ft then
                        return false
                    end
                end
                if buf_name:match("Grug") or buf_name:match("%[CodeCompanion%]") then
                    return false
                end
                return true
            end,
        },
    },
}
