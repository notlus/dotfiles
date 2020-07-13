syntax on
set encoding=utf8
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set ruler
set mouse=a
set colorcolumn=80
set clipboard=unnamed
set cursorline
highlight ColorColumn ctermbg=0 guibg=lightgrey
set smarttab
set termguicolors
set splitright splitbelow

" Initialize plugin system
call plug#begin('~/.vim/plugged')

" Vim LSP related
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'crusoexia/vim-dracula'
Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox 
let g:gruvbox_invert_selection='0'
set background=dark

let g:airline_powerline_fonts = 1

" SourceKit-LSP configuration
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

let mapleader = " "

" Edit vimrc configuration file
nnoremap <Leader>vimrc :e $MYVIMRC<CR>
nnoremap <Leader>vimrc :e ~/.vimrc<CR>

" Reload vimrc configuration file
nnoremap <Leader><CR> :source $MYVIMRC<CR>

" Use ESC to exit terminal mode
tnoremap <ESC> <C-\><C-N>

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
