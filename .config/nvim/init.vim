set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
  require("notlus.cmp")
  require("notlus.gitsigns")
  require("notlus.lsp")
EOF

