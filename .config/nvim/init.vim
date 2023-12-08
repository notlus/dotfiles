set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
  require("notlus.bufferline")
  require("notlus.cmp")
  require("notlus.gitsigns")
  require("notlus.lsp")
  require("notlus.dap")
  require("notlus.dapui")
  require("notlus.treesitter")
  require("notlus.mason")
  require("notlus.copilot")
  require("notlus.dressing")
  require'nvim-tree'.setup {}
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("fzf")
  require('glow').setup()
  require('xbase').setup()
  require('xcodebuild').setup()
EOF

