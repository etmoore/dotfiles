-----------------------------------
---- OPTIONS
-----------------------------------
vim.opt.backup = false -- don't create backup files
vim.opt.swapfile = false -- don't create swapfiles
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 5 -- set number column width to 5 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- ... except when searching for capital letters
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.wrap = false -- don't wrap text
vim.opt.scrolloff = 8 -- keep X lines visible around cursor at all times
vim.opt.sidescrolloff = 8
vim.opt.autoread = true -- reload detected changes from disk
vim.opt.hidden = true -- hide buffers instead of closing them http://nvie.com/posts/how-i-boosted-my-vim/#change-vim-behaviour
vim.opt.foldmethod= 'indent'
vim.opt.foldmethod = 'expr' -- fold using expression -- TODO get this conditionally working if language supports folding by expression
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- fold with treesitter
vim.opt.foldlevel = 1 -- expand first level of indentation
vim.opt.foldenable = false
vim.opt.inccommand = 'split' -- preview substitute command changes
vim.opt.mouse = "a" -- allow mouse usage
vim.opt.completeopt = {"menu", "menuone", "noselect"}

vim.opt.clipboard = 'unnamedplus' -- use '+' register
vim.g.clipboard = {
    name = 'SSH_from_macOS',
    copy = {
        ["+"] = 'pbcopy',
        ["*"] = 'pbcopy'
    },
    paste = {
        ["+"] = 'pbpaste',
        ["*"] = 'pbpaste'
    },
    cache_enabled = 0
}

vim.g.node_host_prog = "~/nenv/bin/node"

vim.cmd "colorscheme tokyonight"

-----------------------------------
---- GENERAL KEYMAPS
-----------------------------------

local opts = { noremap = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-----------------------------------
---- PLUGINS
-----------------------------------
-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

require("packer").startup(function()
    -- plugins here
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use 'folke/tokyonight.nvim' -- colorscheme
    use 'christoomey/vim-tmux-navigator'
    use 'numToStr/Comment.nvim'
    use 'windwp/nvim-autopairs'

    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

-----------------------------------
---- LSP
-----------------------------------
require("nvim-lsp-installer").setup {
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'sumneko_lua', 'intelephense', 'yamlls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach
  }
end

require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'use' }
            }
        }
    }
}

-----------------------------------
---- TELESCOPE
-----------------------------------
require('telescope').setup {}
require('telescope').load_extension('fzf')

keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<Leader>fl", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts) -- ANY string
keymap("n", "<Leader>*", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts) -- grep for word under cursor
keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts) -- open buffers
keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-----------------------------------
---- TREESITTER
-----------------------------------
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    ensure_installed = {'python', 'typescript', 'yaml', 'vim', 'scss', 'ruby', 'regex', 'php', 'make', 'json', 'javascript', 'http', 'html', 'help', 'graphql', 'dockerfile', 'css'},
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    indent = { enable = true },
}

-----------------------------------
---- COMPLETION
-----------------------------------
local cmp = require('cmp')
cmp.setup {
    sources = cmp.config.sources({
        { name = "buffer" },
        { name = "path" },
    }),
    mapping = {
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end
        }),
    },
}

-- command mode completions
-- cmp.setup.cmdline(':', {
--   sources = {
--     { name = 'cmdline' }
--   }
-- })

-- / search completions based on buffer
-- cmp.setup.cmdline('/', {
--     sources = {
--         { name = 'buffer' }
--     }
-- })

-----------------------------------
---- COMMENT
-----------------------------------
require('Comment').setup()
