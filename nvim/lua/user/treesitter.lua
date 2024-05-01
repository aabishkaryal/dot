local nvim_treesitter_status_ok = pcall(require, 'nvim-treesitter')
if not nvim_treesitter_status_ok then
	return
end

local nvim_treesitter_config_status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not nvim_treesitter_config_status_ok then
	return
end

configs.setup {
	ensure_installed = {
		'lua',
		'markdown',
		'markdown_inline',
		'bash',
		'python',
		'c',
		'cpp',
		'dockerfile',
		'dot',
		'gitignore',
		'go',
		'gomod',
		'gosum',
		'graphql',
		'make',
		'nix',
		'proto',
		'rust',
		'sql',
		'yaml',
		'comment',
		'diff',
		'html',
		'javascript',
		'gitattributes',
		'gitignore',
		'gitcommit',
		'json',
		'regex'
	},                 -- put the language you want in this array
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

	highlight = {
		enable = true, -- false will disable the whole extension
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languagesthat will be disabled
		additional_vim_regex_highlighting = false
	},
	autopairs = {
		enable = true
	},
	indent = {
		enable = true,
		disable = {
			'python',
			'css'
		}
	}
}
