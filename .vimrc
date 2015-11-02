set nocompatible              " be iMproved, required
filetype off                  " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Test
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive' " git wrapper
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'ervandew/supertab'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'christoomey/vim-sort-motion'
Plugin 'scrooloose/nerdtree'
Plugin 'rizzatti/dash.vim'

" Color Schemes
Plugin 'Zenburn'
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set autoindent smartindent

" ctrl + L to exit insert mode
:imap <C-L> <Esc>

" Set Zenburn high-contrast as color scheme
" let g:zenburn_high_Contrast=1
" let g:zenburn_old_Visual = 1
" colors zenburn
colors jellybeans

" Treat all numerals as decimal
set nrformats=

" Get off my lawn - no arrow keys!
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Quicker window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to the right and bottom
set splitbelow
set splitright

" Prevent Vim from creating swap files
set nobackup
set nowritebackup
set noswapfile

" Make backspace work like it does in most other apps
set backspace=2

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Line numbers
set number relativenumber
set numberwidth=5

set ruler           " show the cursor position at all times
set laststatus=2    " Always display the status line
set autowrite       " Automatically :write before running commands
set showcmd         " display incomplete commands

" Tab completion like zsh with menu of options
set wildmenu
set wildmode=full

" Remember the last x commands
set history=1000

" remap <C-n> and <C-p> to down and up in command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" expand %% to the path of the active buffer in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" only enable Emmet for html and css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let vim_markdown_preview_hotkey='<C-m>'

" autosource vimrc on save
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" remove trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre *.js,*.py,*.html,*.css,*.rb :call <SID>StripTrailingWhitespaces()
