local opts = { noremap = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--[[ 
    Modes
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
    visual_block_mode = "x",
    term_mode = "t",
    command_mode = "c",
--]]   

-- save and quit shortcuts
keymap("n", "<Leader>w", ":w<CR>", opts)
keymap("n", "<Leader>q", ":q<CR>", opts)
keymap("n", "<Leader><Leader>q", ":qa!<CR>", opts)

-- close current buffer without closing split
keymap("n", "<Leader>b", ":bp|bd #<CR>", opts)

-- open previous buffer
keymap("n", "<Leader>p", "<C-^>", opts)

-- read file changes
keymap("n", "<Leader>e", ":checktime<CR>", opts)

-- open file explorer
keymap("n", "<Leader>n", ":Lexplore 30<CR>", opts)

-- move cursor up and down by visual lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- disable search highlighting (until next search is performed)
keymap("n", "<Leader>h", ":nohlsearch<CR>", opts)

-- remap <C-n> and <C-p> to down and up in command line mode
keymap("c", "<C-p>", "<Up>", opts)
keymap("c", "<C-n>", "<Down>", opts)

-- pane resize
keymap("n", "<Down>", "2<c-w>+", opts)
keymap("n", "<Up>", "2<c-w>-", opts)
keymap("n", "<Right>", "2<c-w><", opts)
keymap("n", "<Left>", "2<c-w>>", opts)

-- Copy current path to clipboard
keymap("n", "<Leader>yp", ':let @*=expand("%")<CR>', opts)
-- Copy current file to clipboard
keymap("n", "<Leader>yf", ':let @*=expand("%:t")<CR>', opts)

-- edit and source $MYVIMRC
keymap("n", "<Leader>ev", ":vsplit $MYVIMRC<CR>", opts)
keymap("n", "<Leader>sv", ":source $MYVIMRC<CR>", opts)

-- telescope
keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<Leader>fl", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts) -- ANY string
keymap("n", "<Leader>*", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts) -- grep for word under cursor
keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts) -- open buffers
keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
