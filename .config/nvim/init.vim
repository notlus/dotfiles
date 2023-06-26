set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
  require("notlus.bufferline")
  require("notlus.cmp")
  require("notlus.gitsigns")
  require("notlus.lspconfig")
  require("notlus.dap")
  require("notlus.dapui")
  require("notlus.treesitter")
  require("notlus.mason")
  require'nvim-tree'.setup {}
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("fzf")
  require('copilot').setup({
      suggestion = {enabled = false},
      panel = {enabled = false},
  })
  require('copilot_cmp').setup()
  require('glow').setup()
  require('lspsaga').setup({
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
      },
      ui = {
        colors = {
          normal_bg = "#022746",
        },
      },
    })
EOF

