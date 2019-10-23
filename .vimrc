set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'flowtype/vim-flow'
Plug 'ludovicchabant/vim-gutentags'
Plug 'romainl/Apprentice'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'mattn/emmet-vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
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

set smartcase
set autoindent smartindent
set ttyfast
" set lazyredraw
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

" disable search highlighting until the next search or N is performed
nnoremap <leader>h :nohlsearch<cr>

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

" The Silver Searcher - use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tags\ " must have trailing space here
endif

" bind K to search for word under cursor using fzf Ag command
" nnoremap K :Ag <c-r><c-w><CR>

" bind K to grep word under cursor using grepprg
nnoremap K :grep! "\b<cword>\b"<CR>:cw<CR>

" bind leader a to start an Ag search with fzf
nnoremap <Leader>a :Ag <c-r><c-w><CR>
" bind leader r to start an Rg search with fzf
nnoremap <Leader>r :Rg <c-r><c-w><CR>?

" polyglot configuration
let g:polyglot_disabled = ['elm'] " let the vim-elm plugin handle this

" window resize
noremap <Down> 2<c-w>+
noremap <Up> 2<c-w>-

" vertical resize
noremap <Right> 2<c-w><
noremap <Left> 2<c-w>>

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
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1 "show hidden files by default

let NERDTreeMinimalUI = 1
" let NERDTreeQuitOnOpen = 1 " Close nerdtree when it opens a file
let NERDTreeAutoDeleteBuffer = 1 "Automatically delete the buffer of the file you just deleted with NerdTree

" Allow vim-tmux-navigator to jump out of nerdtree pane
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Livedown markdown preview
nnoremap gm :LivedownToggle<CR>

" leader <CR> changes inside brackets, automatically setting new lines and indenting
nnoremap <leader><CR> F{ci{<CR><ESC>O


" Airline configuration
let g:airline_theme = "angr"
let g:airline#extensions#branch#enabled = 0

" let g:airline#extensions#tabline#enabled = 1

" Spellchecking and autocomplete, and show all characters
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
  " Hack to get C-h working in NeoVim NOTE: (evanm) disable September 20, 2019
  " delete?
  " nnoremap <BS> <C-W>h

  " preview effects of substitute commmands
  set inccommand=split
endif


" set foldmethod to indent by default, then turn off. enable with zi
set foldmethod=indent
set foldlevel=1 " expand first level of indentation
set nofoldenable

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

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Do the same with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "match:fg:0,128,255" --smart-case '.(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"fzf search hotkeys
nnoremap <C-p> :Files<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>o :Buffers<CR>
nnoremap <leader>/ :Rg 
nnoremap <leader>* :Rg <C-r><C-w><CR>

nnoremap <leader>gd :Gdiff master<CR>
" search for current word under cursor with :Tags fzf command
nnoremap <leader>k :call fzf#vim#tags(expand('<cword>'))<CR>


" QUICKFIX splits
" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>


" COC vim configuration
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Better display for messages
set cmdheight=2
" always show signcolumns
set signcolumn=yes
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" COC airline integration
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" COC Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" COC Use leader + d to show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
