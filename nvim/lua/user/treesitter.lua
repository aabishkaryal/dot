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
        'dockerfile',
        'dot',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'make',
        'nix',
        'proto',
        'rust',
        'sql',
        'typescript',
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
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = {
        ''
    }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {
            'css'
        }, -- list of language  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages that will be disabled
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
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },

    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            include_surrounding_whitespace = true
        }
    }
}
