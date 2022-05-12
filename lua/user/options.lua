-- :help options
local options = {
    backup = false, -- don't create backup files
    swapfile = false, -- don't create swapfiles
    clipboard = unnamedplus, -- use '+' register
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    number = true, -- set numbered lines
    numberwidth = 5, -- set number column width to 5 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    completeopt = { "menuone", "noselect" }, -- show completion even when there's only one option and force user to select
    ignorecase = true, -- ignore case in search
    smartcase = true, -- ... except when searching for capital letters
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    wrap = false, -- don't wrap text
    scrolloff = 8, -- keep X lines visible around cursor at all times
    sidescrolloff = 8,
    autoread = true, -- reload detected changes from disk
    hidden = true, -- hide buffers instead of closing them http://nvie.com/posts/how-i-boosted-my-vim/#change-vim-behaviour
    foldmethod = 'indent', -- fold on indentation
    foldlevel = 1, -- expand first level of indentation
    foldenable = false,
    inccommand = 'split', -- preview substitute command changes
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.formatoptions:append "j" -- join comment lines without duplicate comment symbols
