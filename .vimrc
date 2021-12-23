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
set smarttab
set termguicolors
set splitbelow
set splitright 
set completeopt=menu,menuone,noselect

" Initialize plugin system
call plug#begin('~/.vim/plugged')

" Vim LSP related 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'crusoexia/vim-dracula'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'

" Language servers
Plug 'neovim/nvim-lspconfig'
Plug 'dart-lang/dart-vim-plugin'

" Snippets
Plug 'L3MON4D3/LuaSnip'

" Completions
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula 
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
let g:gruvbox_invert_selection='0'

let g:airline_powerline_fonts = 1

augroup filetype
  au! BufRead,BufNewFile *.swift set ft=swift
augroup END

" Key mappings
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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Comment/uncomment lines with leader key
nmap <Leader>/ gcc

if has("gui_vimr")
    " Toggle the NERDTree browser with the command key
    nmap <D-0> :NERDTreeToggle<CR>

    " Comment/uncomment lines with the command key
    vmap <D-/> gc
    nmap <D-/> gcc
    imap <D-/> <ESC>gcc

    " Find files using Cmd-Shift-f
    nmap <D-S-f> <cmd>Telescope find_files<cr>
endif
