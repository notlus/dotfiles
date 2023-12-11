-- nvim-lsp.lua
return {
  "neovim/nvim-lspconfig",
  requires = {
    "ray-x/lspsaga.nvim",
  },
  after = "cmp-nvim-lsp",
  event = "BufReadPre",
  ft = { 'c', 'cpp', 'objc', 'objcpp', 'dart', 'kotlin', 'lua', 'swift' },

  config = function()
    local lspconfig = require("lspconfig")

    local servers = { "clangd", "sourcekit", "dartls", "kotlin_language_server", "lua_ls" }
    local function setup_servers()
      for _, server in ipairs(servers) do
        local opts = {} -- options table, can be customized per server
        if server == "lua-ls" then
          opts = {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {"vim"},
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
              },
            },
          }
        end
        lspconfig[server].setup(opts)
      end
    end

    setup_servers()
  end,
}
