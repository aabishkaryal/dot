local nvim_treesitter_status_ok = pcall(require, 'nvim-treesitter')
if not nvim_treesitter_status_ok then
  print('tree-sitter not found')
  return
end

local configs = require('nvim-treesitter.configs')

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
  },                    -- put the language you want in this array
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
