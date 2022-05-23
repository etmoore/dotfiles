local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local packer = require("packer")

return packer.startup(function()
    -- plugins here
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use 'folke/tokyonight.nvim' -- colorscheme
    use 'christoomey/vim-tmux-navigator'
    use 'numToStr/Comment.nvim'

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
