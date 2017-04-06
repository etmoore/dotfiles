set nocompatible              " be iMproved, required
filetype off                  " required by Vundle

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tmhedberg/matchit'
Plug 'ervandew/supertab'
Plug 'shime/vim-livedown'
Plug 'scrooloose/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'neomake/neomake'
" Color Schemes
Plug 'flazz/vim-colorschemes'
Plug 'rakr/vim-one'
Plug 'robertmeta/nofrils'

call plug#end()

" save when focus is lost
au FocusLost * :wa

let mapleader = "\<Space>"

" use leader + w to save a file, leader + q to quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" use leader + b to close the current buffer
nnoremap <Leader>b :bd<CR>

syntax on
set autoindent smartindent

" incremental search and ignore case
set is ic

" Remove esc key delay
set timeoutlen=1000 ttimeoutlen=0

" Treat all numerals as decimal
set nrformats=

" Get off my lawn - no arrow keys!
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

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

set nohlsearch      " turn off search term highlighting
map <leader>h :set hlsearch!<cr>

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

" remove trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre *.js,*.py,*.html,*.css,*.rb,*.vue,*.jsx :call <SID>StripTrailingWhitespaces()

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
  " Use ag in CtrlP for listing files. Lightning fast and respects
  " .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" window resize
map + 2<c-w>+
map - 2<c-w>-

" vertical resize
map <Right> 2<c-w><
map <Left> 2<c-w>>

" NERDTree
nmap <leader>n :NERDTreeToggle<cr>

" Livedown markdown preview
nmap gm :LivedownToggle<CR>

" Turn off folding by default
set nofoldenable

" leader <CR> changes inside brackets, automatically setting new lines and indenting
nnoremap <leader><CR> F{ci{<CR><ESC>O

" search in Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Allow vim-tmux-navigator to jump out of nerdtree pane
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Airline configuration
let g:airline_theme = "onedark"
let g:airline#extensions#tabline#enabled = 1

" Spellchecking and autocomplete
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd Filetype gitcommit setlocal spell textwidth=72 "https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
set complete+=kspell

" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsSnippetsDir="~/.vim/snippets/"

" COLOR Configuration
set t_Co=256
set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:nofrils_strbackgrounds=1
if strftime("%H") < 20
  colorscheme nofrils-light
else
  colorscheme nofrils-dark
endif

" cursor shape in neovim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if has('nvim')
  " Hack to get C-h working in NeoVim
  nmap <BS> <C-W>h
endif

" Neomake configuration
autocmd! BufWritePost,BufEnter * Neomake
nmap <Leader>o :lopen<CR>
nmap <Leader>c :lclose<CR>
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }
" if eslintrc file present use eslint, else use standard
if findfile('.eslintrc', '.;') !=# ''
  let g:neomake_javascript_enabled_makers = ['eslint']
  " load local eslint in the project root to avoid global plugin installations
  let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
  let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
else
  let g:neomake_javascript_enabled_makers = ['standard']
endif
" load local eslint in the project root to avoid global plugin installations
