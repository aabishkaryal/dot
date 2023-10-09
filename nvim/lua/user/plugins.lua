local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float {
                border = 'rounded'
            }
        end
    },
    git = {
        clone_timeout = 300 -- Timeout, in seconds, for git clones
    }
}

-- Install your plugins here
return packer.startup(function(use)
    -- Utilities
    use {
        'wbthomason/packer.nvim'
    } -- Have packer manage itself
    use {
        'nvim-lua/plenary.nvim'
    } -- Useful lua functions used by lots of plugins
    use {
        'kyazdani42/nvim-web-devicons'
    } -- Icons

    -- Colorschemes
    use {
        'folke/tokyonight.nvim'
    }
    use {
        'ray-x/starry.nvim'
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter'
    }
    use({
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter'
    })

    -- QOL
    use {
        'windwp/nvim-autopairs'
    } -- Autopairs, integrates with both cmp and treesitter
    use {
        'RRethy/vim-illuminate'
    } -- Highlight the current word under the cursor
    use {
        'lewis6991/gitsigns.nvim'
    } -- Git signs in the gutter
    use({
        'kylechui/nvim-surround',
        tag = '*' -- Use for stability; omit to use `main` branch for the latest features
    }) -- Surround text objects
    use {
        'lukas-reineke/indent-blankline.nvim'
    } -- Indentation guides

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
