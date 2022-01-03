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
  require("notlus.tabnine")
EOF

