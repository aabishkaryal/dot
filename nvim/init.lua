-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    vim.cmd('packadd packer.nvim')
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Use onedark colorscheme
    use 'olimorris/onedarkpro.nvim'

    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim'
        }
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        }
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update {
                with_sync = true
            })
        end
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- Linters and formatters
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Git related plugins
    use 'kdheepak/lazygit.nvim'

    -- Provide icons and colors for nvim
    use 'nvim-tree/nvim-web-devicons'

    -- Nvim tree file explorer
    use {
        'nvim-tree/nvim-tree.lua',
    }

    -- Fancier statusline
    use {
        'nvim-lualine/lualine.nvim',
    }
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    -- Comment code
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Fuzzy Finder (files, lsp, etc)
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            {
                'nvim-lua/plenary.nvim'
            },
            {
                -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
                cond = vim.fn.executable 'make' == 1
            },
            {
                'nvim-telescope/telescope-file-browser.nvim'
            }
        }
    }

    -- bufferline
    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- Test generation for Go
    use {
        'yanskun/gotests.nvim',
        ft = 'go',
        config = function()
            require('gotests').setup()
        end
    }

    use({
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/neotest-go",
            -- Your other test adapters here
        },
        config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup({
                -- your neotest config here
                adapters = {
                    require("neotest-go")({
                        experimental = {
                            test_table = true,
                        },
                        args = { "-count=1", "-timeout=60s" }
                    }),
                },
            })
        end,
    })

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Some aliases to make things easier
local keymap = vim.keymap

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', {
    clear = true
})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC'
})

local file_detection_group = vim.api.nvim_create_augroup('Filetype detection', {
    clear = true
})
-- Set jrnl filetype auto detection
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    callback = function()
        vim.cmd("setfiletype jrnl")
    end,
    group = file_detection_group,
    pattern = '*.jrnl'
})

-- Set <space> as the leader key
-- See `:help mapleader`
-- Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`
vim.opt.guicursor = ''

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 100
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.colorcolumn = '80'
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamedplus'

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.list = true

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
    silent = true
})

-- Remap for dealing with word wrap
-- keymap.set('n', 'k', 'v:count == 0 ? \'gk\' : \'k\'', {
--     expr = true,
--     silent = true
-- })
-- keymap.set('n', 'j', 'v:count == 0 ? \'gj\' : \'j\'', {
--     expr = true,
--     silent = true
-- })

-- vertical split mappings
keymap.set('n', '<leader>vs', '<cmd>vsp<CR>')                   -- open vertical split
keymap.set('n', '<leader>vh', '<cmd>wincmd h<CR>')              -- travel to left vertical screen
keymap.set('n', '<leader>vl', '<cmd>wincmd l<CR>')              -- travel to right vertical screen
-- tab mappings
keymap.set('n', '<leader>tc', '<cmd>tabnew | NvimTreeOpen<CR>') -- create new tab
keymap.set('n', '<leader>tq', '<cmd>tabonly<CR>')               -- quit all other tabs
keymap.set('n', '<leader>tn', '<cmd>+tabnext<CR>')              -- go to next tab
keymap.set('n', '<leader>tp', '<cmd>-tabnext<CR>')              -- go to previous tab
-- window movements
keymap.set('n', '<leader>wh', '<cmd>wincmd h<CR>')              -- travel to left window
keymap.set('n', '<leader>wl', '<cmd>wincmd l<CR>')              -- travel to the right window
-- file movements
keymap.set('n', '<leader>md', '<C-d>zz')                        -- move the cursor half a screen down and center the cursor on the screen
keymap.set('n', '<leader>mu', '<C-u>zz')                        -- move the cursor half a screen up and center the cursor on the screen
keymap.set('n', 'n', 'nzzzv')                                   -- move the cursor to next occurrence of the search pattern and center the cursor on the screen
keymap.set('n', 'N', 'Nzzzv')                                   -- move the cursor to previous occurrence of the search pattern and center the cursor on the screen

-- Disable arrow keys to promote vi muscle memory
keymap.set('n', '<up>', '<cmd>echoerr "Umm, use k instead"<CR>')
keymap.set('n', '<down>', '<cmd>echoerr "Umm, use j instead"<CR>')
keymap.set('n', '<left>', '<cmd>echoerr "Umm, use h instead"<CR>')
keymap.set('n', '<right>', '<cmd>echoerr "Umm, use l instead"<CR>')

-- Terminal
keymap.set('n', '<leader>tt', '<cmd>tabnew | terminal<CR>')
-- Help with keymaps
keymap.set('n', '<leader>hh', '<cmd>vsp | wincmd l | e /Users/aabi/.config/nvim/README.md<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*'
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        section_separators = {
            left = '',
            right = ''
        },
        component_separators = {
            left = '',
            right = ''
        }
    },
    sections = {
        lualine_a = {
            'mode'
        },
        lualine_b = {
            'branch',
            'diff'
        },
        lualine_c = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 0            -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_x = {
            {
                'diagnostics',
                sources = {
                    'nvim_diagnostic',
                    'nvim_lsp'
                },
                symbols = {
                    error = ' ',
                    warn = ' ',
                    info = ' ',
                    hint = ' '
                },
                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = 'DiagnosticError', -- Changes diagnostics' error color.
                    warn = 'DiagnosticWarn',   -- Changes diagnostics' warn color.
                    info = 'DiagnosticInfo',   -- Changes diagnostics' info color.
                    hint = 'DiagnosticHint'    -- Changes diagnostics' hint color.
                },
                colored = true,                -- Displays diagnostics status in color if set to true.
                update_in_insert = false,      -- Update diagnostics in insert mode.
                always_visible = false         -- Show diagnostics even if there are none.
            },
            'encoding',
            'filetype'
        },
        lualine_y = {
            'location'
        },
        lualine_z = {
            'tabs'
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_x = {
            'location'
        },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {
        'fugitive'
    }
}

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
    space_char_blankline = ' ',
    char = '┊',
    show_trailing_blankline_indent = false
}

require('nvim-tree').setup {
    view = {
        width = 40,
        number = true,
        relativenumber = true
    },
    filters = {
        custom = {
            '.git'
        }
    },
    renderer = {
        system_open = {
            cmd = "open"
        }
    }
}

local nvimTreeAPI = require('nvim-tree.api')

keymap.set('n', '<leader>nt', function()
    nvimTreeAPI.tree.toggle({
        path = nil,
        current_window = false,
        find_file = false,
        update_root = false,
        focus = false
    })
end, {
    desc = '[T]oggle [N]vimTree'
})
keymap.set('n', '<leader>nf', '<cmd>NvimTreeFocus<CR>', {
    desc = '[F]ocus [N]vimTree'
})

-- Lazy Git
local lazygit_group = vim.api.nvim_create_augroup('LazyGit', {
    clear = true
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function(_)
        require('lazygit.utils').project_root_dir()
    end,
    group = lazygit_group,
})

keymap.set('n', '<Leader>lg', '<cmd>LazyGit<CR>', {
    desc = '[L]azy [G]it'
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local action_layout = require('telescope.actions.layout')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                    ['<esc>'] = actions.close,
                    ['<C-p>'] = action_layout.toggle_preview
            },
            i = {
                    ['<C-k>'] = false,
                    ['<C-p>'] = action_layout.toggle_preview,
                    ['<C-u>'] = false,
                    ['<C-d>'] = false
            }
        }
    },
    extensions = {
        file_browser = {
            theme = 'dropdown',
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            initial_mode = 'normal'
        }
    }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
keymap.set('n', '<leader>?', builtin.oldfiles, {
    desc = '[?] Find recently opened files'
})
keymap.set('n', '<leader><space>', builtin.buffers, {
    desc = '[ ] Find existing buffers'
})
keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false
    })
end, {
    desc = '[/] Fuzzily search in current buffer]'
})

keymap.set('n', '<leader>sf', builtin.find_files, {
    desc = '[S]earch [F]iles'
})
keymap.set('n', '<leader>sh', builtin.help_tags, {
    desc = '[S]earch [H]elp'
})
keymap.set('n', '<leader>sw', builtin.grep_string, {
    desc = '[S]earch current [W]ord'
})
keymap.set('n', '<leader>sg', builtin.live_grep, {
    desc = '[S]earch by [G]rep'
})
keymap.set('n', '<leader>sd', builtin.diagnostics, {
    desc = '[S]earch [D]iagnostics'
})
keymap.set('n', '<leader>sc', function()
    require('telescope').extensions.file_browser.file_browser({
        path = '%:p:h',
        cwd = vim.fn.expand('%:p:h'),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        initial_mode = 'normal'
    })
end, {
    desc = '[S]earch [C]urrent directory'
})
keymap.set('n', '<leader>ss', function()
    local opts = {} -- define here if you want to define something
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
        builtin.git_files(opts)
    else
        builtin.find_files(opts)
    end
end, {
    desc = '[S]earch git [S]ource'
})
keymap.set('n', '<leader>sk', builtin.keymaps, {
    desc = '[S]how [K]eymaps'
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'dot',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'graphql',
        'help',
        'html',
        'http',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'rust',
        'sql',
        'svelte',
        'typescript',
        'yaml'
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true,
        disable = {
            'python'
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>'
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer'
            },
            goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer'
            },
            goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer'
            },
            goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer'
            }
        },
        swap = {
            enable = true,
            swap_next = {
                    ['<leader>a'] = '@parameter.inner'
            },
            swap_previous = {
                    ['<leader>A'] = '@parameter.inner'
            }
        }
    }
}

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev)
keymap.set('n', ']d', vim.diagnostic.goto_next)
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

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
            desc = 'LSP: ' .. desc
        end

        keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc
        })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('<leader>gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>gtd', vim.lsp.buf.type_definition, '[G]oto [T]ype [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wf', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace List [F]olders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    nmap('<leader>ff', vim.lsp.buf.format, '[F]ormat Buffer')
end

-- Setup neovim lua configuration
require('neodev').setup()

local neotest = require("neotest")
local test_keymaps_group = vim.api.nvim_create_augroup('TestKeymapsGroup', {
    clear = true
})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter' }, {
    callback = function(args)
        local nmap = function(keys, func, desc)
            keymap.set('n', keys, func, {
                buffer = args.buf,
                desc = desc
            })
        end

        nmap('<leader>tl', function()
            neotest.run.run()
        end, '[T]est Current [Line]')

        nmap('<leader>tf', function()
            neotest.run.run(vim.fn.expand('%'))
        end, '[T]est Current [F]ile')
    end,
    group = test_keymaps_group,
    pattern = { '*.go' },
    desc = "setup keymaps for tests in neo-test"
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    actionlint = {},
    eslint_d = {},
    codespell = {},
    cpplint = {},
    hadolint = {},
    jsonlint = {},
    shellcheck = {},
    yamllint = {},
    gofumpt = {},
    gopls = {},
    goimports = {},
    prettierd = {},
    gomodifytags = {},
    sumneko_lua = {
        Lua = {
            workspace = {
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
}

servers['sql-formatter'] = {}
servers['svelte-language-server'] = {}
servers['gotests'] = {}
servers['tailwindcss-language-server'] = {}
servers['typescript-language-server'] = {}

-- {"actionlint", "eslint_d", "codespell", "cpplint", "gospel", "hadolint", "jsonlint",
-- "shellcheck", "yamllint", "gofumpt", "goimports", "prettierd", "gomodifytags", "sumneko_lua",
-- "sql-formatter", "gotests", "tailwindcss-language-server", "typescript-language-server", "gopls"}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
        }
    },
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true
})

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
        }
    end
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local sources = {
    {
        name = 'nvim_lsp'
    },
    {
        name = 'luasnip'
    }
}


cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ---@diagnostic disable-next-line: missing-parameter
            ['<C-Space>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
            ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            'i',
            's'
        }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's'
        })
    },
    sources = sources,
}

local null_ls = require('null-ls')

null_ls.setup {
    sources = {
        -- Code actions
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gomodifytags,

        -- Completion
        null_ls.builtins.completion.luasnip,

        -- Diagnostic
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.zsh,
        -- Formatting
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.sql_formatter

    }
}

require('bufferline').setup({
    options = {
        mode = 'tabs',
        separator_style = 'slant',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true
    },
    highlights = {
        separator = {
            fg = '#073642',
            bg = '#002b36'
        },
        separator_selected = {
            fg = '#073642'
        },
        background = {
            fg = '#657b83',
            bg = '#002b36'
        },
        buffer_selected = {
            fg = '#fdf6e3',
            bold = true
        },
        fill = {
            bg = '#073642'
        }
    }
})
