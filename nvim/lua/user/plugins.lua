local fn = vim.fn

---
-- context_commentstring nvim-treesitter module is deprecated, use require('ts_context_commentstring').setup {} and set vim.g.skip_ts_context_commentstring_module = true to speed up loading instead.
-- This feature will be removed in ts_context_commentstring version in the future (see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82 for more info)
---
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
	-- basic dependencies
	use { 'wbthomason/packer.nvim' }       -- Have packer manage itself
	use { 'nvim-lua/plenary.nvim' }        -- Useful lua functions used by lots of plugins
	use { 'kyazdani42/nvim-web-devicons' } -- icons used by various plugins

	-- Colorschemes
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use { 'Mofiqul/dracula.nvim' }
	use { 'folke/tokyonight.nvim' }
	use { "rebelot/kanagawa.nvim" }
	use { "ellisonleao/gruvbox.nvim" }

	-- cmp plugins
	use { 'hrsh7th/nvim-cmp' }         -- The completion plugin
	use { 'hrsh7th/cmp-buffer' }       -- buffer completions
	use { 'hrsh7th/cmp-path' }         -- path completions
	use { 'saadparwaiz1/cmp_luasnip' } -- snippet completions
	use { 'hrsh7th/cmp-nvim-lsp' }     -- lsp completion
	use { 'hrsh7th/cmp-nvim-lua' }     -- lua completion

	-- snippets
	use { 'L3MON4D3/LuaSnip' }

	-- LSP
	use { 'neovim/nvim-lspconfig' }             -- enable LSP
	use { 'williamboman/mason.nvim' }           -- easy install LSP, Formatters and so on
	use { 'williamboman/mason-lspconfig.nvim' } -- easy configure mason with lsp
	use { 'jose-elias-alvarez/null-ls.nvim' }   -- for formatters and linters
	use { "fladson/vim-kitty" }
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{
				-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
				cond = vim.fn.executable 'make' == 1
			},
			{ 'nvim-telescope/telescope-file-browser.nvim' }
		}
	} -- general fuzzy finder over lists

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter' } -- interface for nvim to treesitter; a syntax parser for languages
	use({
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
		requires = 'nvim-treesitter/nvim-treesitter'
	}) -- Syntax aware text-objects, select, move, swap, and peek support with treesitter
	use {
		'JoosepAlviste/nvim-ts-context-commentstring',
		config = function()
			require("ts_context_commentstring").setup { enable = true }
		end
	} -- support context_commentstring


	-- QOL
	use { 'lukas-reineke/indent-blankline.nvim' } -- place indent guides on blankline
	use { 'windwp/nvim-autopairs' }               -- Autopairs, integrates with both cmp and treesitter
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end
	}                                   -- suppport auto comments
	use { 'kyazdani42/nvim-tree.lua' }  -- alternate file explorer
	use { 'akinsho/bufferline.nvim' }   -- manage tabs
	use { 'moll/vim-bbye' }             -- better close buffers
	use { 'nvim-lualine/lualine.nvim' } -- statusline at bottom of window
	use { 'RRethy/vim-illuminate' }     -- illuminate same token on file


	-- DAP
	use { 'mfussenegger/nvim-dap' } -- debug support for neovim
	use {
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
	} -- gui for debug mode
	use {
		'dreamsofcode-io/nvim-dap-go',
		requires = {
			{ 'mfussenegger/nvim-dap' }
		},
		config = function(_, opts)
			require('dap-go').setup(opts)
		end
	} -- debug support for golang
	use {
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		requires = {
			{ 'mfussenegger/nvim-dap' }
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			local dap_python = require('dap-python')
			local conda_path = os.getenv("CONDA_PREFIX")
			if conda_path then
				path = conda_path .. "/bin/python"
			end
			local venv_path = os.getenv("VIRTUAL_ENV")
			if venv_path then
				path = venv_path .. "/bin/python"
			end
			dap_python.setup(path)
		end,
	} -- debug support for python

	-- go utilities
	use {
		'olexsmir/gopher.nvim',
		ft = { 'go' },
		requires = { -- dependencies
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter'
		},
		config = function()
			require 'user.gopher'
		end,
	} -- interface to go tooling

	-- Context
	use {
		'SmiteshP/nvim-navic',
		requires = 'neovim/nvim-lspconfig'
	}
	use({
		'utilyre/barbecue.nvim',
		tag = '*',
		requires = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons' -- optional dependency
		}
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
