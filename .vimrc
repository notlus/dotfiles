syntax on
set encoding=utf8
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hidden

" Give more space for displaying messages.
set cmdheight=2


" Ignore case and be smart about it
set ignorecase
set smartcase

set ruler
set mouse=a
set colorcolumn=100
set clipboard=unnamed
set cursorline
highlight ColorColumn ctermbg=0 guibg=lightgrey
set smarttab
set termguicolors
set splitbelow
set splitright 

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
Plug 'tpope/vim-commentary'

Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula 
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

" Navigate between split views
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" Toggle the NERDTree browser with the leader key
nnoremap <Leader>0 :NERDTreeToggle<CR>

" Comment/uncomment lines with leader key
nmap <Leader>/ gcc

if has("gui_vimr")
    " Toggle the NERDTree browser with the command key
    nmap <D-0> :NERDTreeToggle<CR>

    " Comment/uncomment lines with the command key
    vmap <D-/> gc
    nmap <D-/> gcc
    imap <D-/> <ESC>gcc
endif
