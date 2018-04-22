set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/matchit'
Plug 'ervandew/supertab'
Plug 'shime/vim-livedown'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rizzatti/dash.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'posva/vim-vue'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'elmcast/elm-vim'
Plug 'w0rp/ale'
Plug 'flowtype/vim-flow'
Plug 'ludovicchabant/vim-gutentags'
Plug 'romainl/Apprentice'

" Autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'steelsojka/deoplete-flow'

" Color Schemes
Plug 'flazz/vim-colorschemes'

call plug#end()

filetype plugin indent on

" set the leader key to space
let mapleader = "\<Space>"

nnoremap <Leader>sp :echo @%<CR>

" use leader + w to save a file, leader + q to quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" use leader + b to close the current buffer without closing the split
nnoremap <Leader>b :bp\|bd #<CR>

" use leader + p to open previous buffer
nnoremap <leader>p <C-^>

set autoindent smartindent
set ttyfast
set lazyredraw
set autoread
" reload all files from disk (useful after checking out a different branch)
nnoremap <Leader>e :checktime<CR>

" incremental search and ignore case
set is ic

" hide buffers instead of closing them
" see http://nvie.com/posts/how-i-boosted-my-vim/#change-vim-behaviour
set hidden

" turn off text wrapping by default
set nowrap

" move cursor up and down by visual lines
nnoremap j gj
nnoremap k gk

" join commmnt lines without duplicate comment symbols
set formatoptions+=j

" Remove esc key delay
set timeoutlen=1000 ttimeoutlen=0

" Treat all numerals as decimal
set nrformats=

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

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

" Line numbers
set number
set numberwidth=5

set ruler           " show the cursor position at all times
set laststatus=2    " Always display the status line
set autowrite       " Automatically :write
set showcmd         " display incomplete commands

set nohlsearch      " turn off search term highlighting
" toggle search term highlighting
nnoremap <leader>h :set hlsearch!<cr>

" Tab completion like zsh with menu of options
set wildmenu
set wildmode=full

" Remember the last x commands and undos
set history=1000
set undolevels=1000

" remap <C-n> and <C-p> to down and up in command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

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
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tags\ " Use ag over grep
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" polyglot configuration
let g:polyglot_disabled = ['elm'] " let the vim-elm plugin handle this

" window resize
map <Down> 2<c-w>+
map <Up> 2<c-w>-

" vertical resize
map <Right> 2<c-w><
map <Left> 2<c-w>>

" Toggle quickfix
nnoremap <leader>c :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" Toggle loclist
nnoremap <leader>l :call LoclistToggle()<cr>
let g:loclist_is_open = 0
function! LoclistToggle()
    if g:loclist_is_open
        lclose
        let g:loclist_is_open = 0
    else
        lopen
        let g:loclist_is_open = 1
    endif
endfunction

" NERDTree Configuration
nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeMinimalUI = 1
" let NERDTreeQuitOnOpen = 1 " Close nerdtree when it opens a file
let NERDTreeAutoDeleteBuffer = 1 "Automatically delete the buffer of the file you just deleted with NerdTree

" Allow vim-tmux-navigator to jump out of nerdtree pane
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Livedown markdown preview
nmap gm :LivedownToggle<CR>

" leader <CR> changes inside brackets, automatically setting new lines and indenting
nnoremap <leader><CR> F{ci{<CR><ESC>O

" search in Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Airline configuration
let g:airline_theme = "onedark"
" let g:airline#extensions#tabline#enabled = 1

" Spellchecking and autocomplete
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile *.md setlocal wrap

"https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
autocmd Filetype gitcommit setlocal spell textwidth=72
set complete+=kspell

" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsSnippetsDir="~/.vim/snippets/"

" fzf config
nnoremap <C-p> :Files<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>o :Buffers<CR>
nnoremap <leader>/ :BLines<CR>
" search for current word under cursor with :Tags fzf command
nnoremap <leader>k :call fzf#vim#tags(expand('<cword>'))<CR>

" COLOR Configuration
set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif
set background=dark " has to come before the colorscheme
let g:one_allow_italics = 1
" colorscheme onedark
colorscheme apprentice
set cursorline

" https://github.com/rakr/vim-one#tmux-support
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" change cursor shape in insert mode
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

if has('nvim')
  " Hack to get C-h working in NeoVim
  nmap <BS> <C-W>h
endif

" set foldmethod to indent by default, then turn off. enable with zi
set foldmethod=indent
set foldlevel=1 " expand first level of indentation
set nofoldenable

" ALE Configuration
" fix files automatically on save.
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'python': ['autopep8', 'remove_trailing_lines', 'trim_whitespace'],
\}
" lint fix when saving a file
let g:ale_fix_on_save = 1 " was not working consistently…
nnoremap <leader>af :ALEFix<cr>
let g:airline#extensions#ale#enabled = 1

" Copy current file to clipboard
nnoremap <leader>yf :let @*=expand("%")<cr>
" Set clipboard as default register
set clipboard=unnamedplus

" Clipboard Configuration
if has('nvim')
    let g:clipboard = {
        \   'name': 'SSH_from_macOS',
        \   'copy': {
        \      '+': 'pbcopy',
        \      '*': 'pbcopy',
        \    },
        \   'paste': {
        \      '+': 'pbpaste',
        \      '*': 'pbpaste',
        \   },
        \   'cache_enabled': 0,
        \ }
endif

" Fast editing and sourcing of vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog  = '/usr/local/bin/python3'

" Deoplete configuration
" let g:deoplete#enable_at_startup = 1
" Deoplete flow plugin configuration
" function! StrTrim(txt)
"   return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" endfunction

" let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

" if g:flow_path != 'flow not found'
"   let g:deoplete#sources#flow#flow_bin = g:flow_path
" endif
