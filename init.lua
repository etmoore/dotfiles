-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------
---- PLUGINS
-----------------------------------
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
	-- NOTE: First, some plugins that don't require any configuration

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	"tpope/vim-surround",
	"tpope/vim-unimpaired",

	"christoomey/vim-tmux-navigator",

	"github/copilot.vim",

	-- allow repeating plugin commands with '.'
	"tpope/vim-repeat",

	-- automatically generate tags
	"ludovicchabant/vim-gutentags",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- optional, for file icon
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 45,
				},
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
		},
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		-- Theme inspired by Atom
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
}, {})

-----------------------------------
---- Settings
-----------------------------------
-- See `:help vim.o`

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

vim.o.swapfile = false -- don't create swapfiles

vim.o.wrap = false -- don't wrap text
vim.o.cursorline = true -- highlight the current line
vim.o.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.o.hidden = true -- hide buffers instead of closing them http://nvie.com/posts/how-i-boosted-my-vim/#change-vim-behaviour
vim.o.foldmethod = "indent"
vim.o.foldlevel = 1 -- expand first level of indentation
vim.o.foldenable = false
vim.o.inccommand = "split" -- preview substitute command changes
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"
vim.g.clipboard = {
	name = "SSH_from_macOS",
	copy = {
		["+"] = "pbcopy",
		["*"] = "pbcopy",
	},
	paste = {
		["+"] = "pbpaste",
		["*"] = "pbpaste",
	},
	cache_enabled = 0,
}

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-----------------------------------
---- GENERAL KEYMAPS
-----------------------------------

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save and quit shortcuts
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")

-- close current buffer without closing split
vim.keymap.set("n", "<Leader>b", ":bp|bd #<CR>")

-- open previous buffer
vim.keymap.set("n", "<Leader>p", "<C-^>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- disable search highlighting (until next search is performed)
vim.keymap.set("n", "<Leader>h", ":nohlsearch<CR>")

-- remap <C-n> and <C-p> to down and up in command line mode
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- pane resize
vim.keymap.set("n", "<Down>", "2<c-w>+")
vim.keymap.set("n", "<Up>", "2<c-w>-")
vim.keymap.set("n", "<Right>", "2<c-w><")
vim.keymap.set("n", "<Left>", "2<c-w>>")

-- faster scroll
vim.keymap.set("n", "<C-e>", "4<C-e>")
vim.keymap.set("n", "<C-y>", "4<C-y>")

-- Copy current path to clipboard
vim.keymap.set("n", "<Leader>yp", ':let @*=expand("%")<CR>')
-- Copy current file to clipboard
vim.keymap.set("n", "<Leader>yf", ':let @*=expand("%:t")<CR>')

-- edit and source $MYVIMRC
vim.keymap.set("n", "<Leader>ev", ":vsplit $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>sv", ":source $MYVIMRC<CR>")

-- fugitive diff split
vim.keymap.set("n", "<Leader>gd", ":Gvdiffsplit @...master<CR>")

-- Gitsigns
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<Leader>hp", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<Leader>gm", ":Gitsigns change_base master true<CR>")
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")

-- nvim-tree
vim.keymap.set("n", "<Leader>nn", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>nf", ":NvimTreeFindFile<CR>")

-----------------------------------
---- HIGHLIGHT ON YANK
-----------------------------------
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-----------------------------------
---- TELESCOPE
-----------------------------------
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<esc>"] = actions.close,
				["<C-r>"] = action_layout.toggle_preview,
			},
		},
		path_display = function(opts, path)
			local tail = require("telescope.utils").path_tail(path)
			return string.format("%s (%s)", tail, path)
		end,
	},
	pickers = {
		buffers = {
			sort_mru = true, -- sort by most recently used
		},
		live_grep = {
			mappings = {
				i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine }, -- refine results w/ fuzzy find
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>o", require("telescope.builtin").buffers, { desc = "Find [O]pen buffers" })
vim.keymap.set(
	"n",
	"<leader>/",
	require("telescope.builtin").current_buffer_fuzzy_find,
	{ desc = "[/] Fuzzily search in current buffer" }
)
vim.keymap.set("n", "<leader>*", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sF", function()
	require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
end, { desc = "[S]earch ALL [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sg", function()
	require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "[S]earch open files by [G]rep" })
vim.keymap.set("n", "<leader>sG", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sc", require("telescope.builtin").command_history, { desc = "[S]earch [C]ommand History" })
vim.keymap.set(
	"n",
	"<leader>ss",
	require("telescope.builtin").lsp_document_symbols,
	{ desc = "[S]earch Doc [S]ymbols" }
)
vim.keymap.set(
	"n",
	"<leader>sS",
	require("telescope.builtin").lsp_dynamic_workspace_symbols,
	{ desc = "[S]earch Workspace [S]ymbols" }
)
vim.keymap.set("n", "<leader>st", require("telescope.builtin").tags, { desc = "[S]earch [T]ags" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").lsp_references, { desc = "[S]earch [R]eferenes" })

-----------------------------------
---- TREESITTER
-----------------------------------
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"python",
		"typescript",
		"yaml",
		"vim",
		"scss",
		"ruby",
		"regex",
		"php",
		"make",
		"json",
		"javascript",
		"http",
		"html",
		"graphql",
		"dockerfile",
		"css",
		"tsx",
	},
	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>dh", vim.diagnostic.disable, { desc = "Hide diagnostics" })
vim.keymap.set("n", "<leader>ds", vim.diagnostic.enable, { desc = "Show diagnostics" })

-- prevent errors appearing in-line
vim.diagnostic.config({ virtual_text = false })

-----------------------------------
---- LANGUAGE SERVER PROTOCOL (LSP)
-----------------------------------
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	pyright = {},
	intelephense = {},
	yamlls = {},
	eslint = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim", "use", "require" },
			},
		},
	},
	tsserver = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- require("lspconfig").flow.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
--
-----------------------------------
---- COMPLETION
-----------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

require("luasnip.loaders.from_vscode").lazy_load()
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback) -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
	}),
})

-----------------------------------
---- CUSTOM FUNCTIONS
-----------------------------------
-- TODO convert this to a lua function
vim.cmd([[
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
    let url=trim(system("src search -json '" . searchString . "' | jq --raw-output '" . jqFilter . "'"))

    " print url for visual confirmation, as msg to avoid 'Hit enter' prompt
    echomsg url

    " copy url to the clipboard
    let @*=url
endfunction
]])

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
