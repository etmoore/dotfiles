local o = vim.o -- editor options
local g = vim.g -- global variables

-- :help options
o.backup = false -- don't create backup files
o.swapfile = false -- don't create swapfiles
o.clipboard = unnamedplus -- use '+' register
o.cmdheight = 2 -- more space in the neovim command line for displaying messages
o.number = true -- set numbered lines
o.numberwidth = 5 -- set number column width to 5 {default 4}
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.ignorecase = true -- ignore case in search
o.smartcase = true -- ... except when searching for capital letters
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.undofile = true -- enable persistent undo
o.updatetime = 300 -- faster completion (4000ms default)
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.tabstop = 4 -- insert 2 spaces for a tab
o.cursorline = true -- highlight the current line
o.wrap = false -- don't wrap text
o.scrolloff = 8 -- keep X lines visible around cursor at all times
o.sidescrolloff = 8
o.autoread = true -- reload detected changes from disk
o.hidden = true -- hide buffers instead of closing them http://nvie.com/posts/how-i-boosted-my-vim/#change-vim-behaviour
o.foldmethod= 'indent'
-- o.foldmethod = 'expr' -- fold using expression -- TODO get this conditionally working if language supports folding by expression
-- o.foldexpr = 'nvim_treesitter#foldexpr()' -- fold with treesitter
o.foldlevel = 1 -- expand first level of indentation
o.foldenable = false
o.inccommand = 'split' -- preview substitute command changes
o.mouse = "a" -- allow mouse usage

g.node_host_prog = "~/nenv/bin/node"
