set nocompatible              " be iMproved, required
filetype off                  " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'tmhedberg/matchit'
Plugin 'ervandew/supertab'
Plugin 'shime/vim-livedown'
Plugin 'scrooloose/nerdtree'
Plugin 'rizzatti/dash.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-rails'
Plugin 'mxw/vim-jsx'
Plugin 'HerringtonDarkholme/yats'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'posva/vim-vue'
Plugin 'stanangeloff/php.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' " snippets for ultisnips

" Color Schemes
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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

" Cursor changes to bar in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

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

" Make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1

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

" set the default register to the system keyboard
set clipboard=unnamed

" only enable Emmet for html and css
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

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

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:jsx_ext_required = 0
let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']
nmap <leader>s :SyntasticToggleMode<cr>

" Syntastic filetype configurations
let g:syntastic_javascript_checkers = ['eslint']

" NERDTree
nmap <leader>n :NERDTree<cr>

" TagBar
nmap <leader>t :TagbarToggle<cr>

" Livedown markdown preview
nmap gm :LivedownToggle<CR>

" Turn off folding by default
set nofoldenable

" leader <CR> changes inside brackets, automatically setting new lines and
" indenting
nnoremap <leader><CR> F{ci{<CR><ESC>O

" search in Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Allow vim-tmux-navigator to jump out of nerdtree pane
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Airline configuration
let g:airline_theme = "raven"
let g:airline#extensions#tabline#enabled = 1

" Spellchecking and autocomplete
" autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsSnippetsDir="~/.vim/snippets/"

" Color Configuration
set t_Co=256
set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme vydark
