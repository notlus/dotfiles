return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            view = "cmdline_popup",
        },
        lsp = {
            -- override markdown rendering so that plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        notify = {
            enabled = false,
            view = "notify",
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
        routes = {
            { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
            { filter = { event = "msg_show", kind = "", find = "change" }, opts = { skip = true } },
        },
    },
}
