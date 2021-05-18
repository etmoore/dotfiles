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
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'flowtype/vim-flow'
Plug 'ludovicchabant/vim-gutentags'
Plug 'arcticicestudio/nord-vim'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'AndrewRadev/dsf.vim'
Plug 'wting/cheetah.vim'
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
" reload all files from disk (useful after checking out a different branch)
set autoread
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
" don't show in nerdtree
let NERDTreeIgnore = ['\.pyc$']

" leader <CR> changes inside brackets, automatically setting new lines and indenting
nnoremap <leader><CR> F{ci{<CR><ESC>O


" Spellchecking and autocomplete, and show all characters
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile *.md setlocal wrap

"https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
autocmd Filetype gitcommit setlocal spell textwidth=72
set complete+=kspell


" COLOR Configuration
set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif

" all colorscheme configurations must be applied before colorscheme command
set background=dark
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1 " quieter difff colors
colorscheme nord
set cursorline


" https://github.com/rakr/vim-one#tmux-support
" TODO confirm if this is needed anymore
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum


" gitgutter config
" set gitgutter base to merge-base w/ master, making it easy to see what has changed in the current branch
let mergebase=trim(system('git merge-base @ master'))
nnoremap <leader>gm :let g:gitgutter_diff_base=mergebase<cr> :e<cr>

" change cursor shape in insert mode
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

if has('nvim')
  " preview effects of substitute commmands
  set inccommand=split
endif


" set foldmethod to indent by default, then turn off. enable with zi
set foldmethod=indent
set foldlevel=1 " expand first level of indentation
set nofoldenable

" Copy current path to clipboard
nnoremap <leader>yp :let @*=expand("%")<cr>
" Copy current file to clipboard
nnoremap <leader>yf :let @*=expand("%:t")<cr>
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

" set python executable paths (for Coc)
let g:python_host_prog  = '~/virtualenvs/py2neovim/bin/python'
let g:python3_host_prog  = '~/virtualenvs/py3neovim/bin/python'
" set node.js host path
let g:node_host_prog='~/.npm-prefix/lib/node_modules/neovim/bin/cli.js'

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

" Augmenting Rg command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
"   (<q-args>) position prevents escaping of input
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "match:fg:0,128,255" --smart-case '.(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:30%')
  \           : fzf#vim#with_preview('right:30%:hidden', '?'),
  \   <bang>0)

let g:fzf_preview_window = 'right:30%'

"fzf search hotkeys
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :Files<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>L :BLines<CR>
nnoremap <leader>o :Buffers<CR>
nnoremap <leader>/ :Rg 
nnoremap <leader>* :Rg -F "<C-r><C-w>"<CR>


" Fugitive config
nnoremap <leader>gd :Gvdiffsplit @...master<CR>


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
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" cnoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" cnoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" COC Use <Tab> and <S-Tab> for navigate completion list:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" COC Use leader + d to show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" show function signature help if available when entering insert mode
autocmd InsertEnter * call CocActionAsync('showSignatureHelp')

" open CocList diagnostics
nnoremap <leader>k :CocList --normal diagnostics<CR>
" open CocList
nnoremap <leader>C :CocList<CR>

" generate coc status for statusline
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, ' ')
endfunction


" Statusline Configuration
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%{StatusDiagnostic()}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

" Gutentags configuration
" Don't generate tags for gitignored files
" https://github.com/universal-ctags/ctags/issues/218#issuecomment-377731658
let g:gutentags_file_list_command = 'rg --files'

" Copy Sourcegraph link to file + line number to clipboard
nnoremap <leader>sl :call SourcegraphLink()<cr>
function! SourcegraphLink()
    " build the sourcegraph search string
    let repo=trim(system('basename `git rev-parse --show-toplevel`')) " trim() removes newline char
    let fileName=expand("%") " current file name (relative to cwd)
    let searchString="repo:" . repo . " file:" . fileName

    " build the jq 'filter' string that builds the url
    " https://stedolan.github.io/jq/manual/#Stringinterpolation-\(foo)
    let lineNumber=string(line("."))
    let jqFilter='"\(.SourcegraphEndpoint)\(.Results[0].file.url)#L' . lineNumber . '"' " using string interpolation to build url

    " get the sourcegraph url
    " --raw-output prevents wrapping output in quotes
    let url=system("src search -json '" . searchString . "' | jq --raw-output '" . jqFilter . "'")

    " print url for visual confirmation, as msg to avoid 'Hit enter' prompt
    echomsg url

    " copy url to the clipboard
    let @*=url
endfunction
