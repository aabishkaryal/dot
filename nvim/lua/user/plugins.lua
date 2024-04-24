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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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
  use { 'wbthomason/packer.nvim' }              -- Have packer manage itself
  use { 'nvim-lua/plenary.nvim' }               -- Useful lua functions used by lots of plugins
  use { 'kyazdani42/nvim-web-devicons' }        -- Icons for neovim
  use { 'lukas-reineke/indent-blankline.nvim' } -- show lines for indents
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  } -- Add keybindings for comments

  -- Colorschemes
  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }
  use { 'Mofiqul/dracula.nvim' }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require("ts_context_commentstring").setup { enable = true }
    end
  } -- Add support for comments if multiple languages are in single file like react, etc.



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
