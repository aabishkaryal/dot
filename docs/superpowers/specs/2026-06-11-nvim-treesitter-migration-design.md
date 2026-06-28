# nvim-treesitter Migration to Main Branch (Neovim 0.12)

## Context

Neovim 0.12 absorbed treesitter highlighting, folding, and injection natively. The `nvim-treesitter` plugin underwent an incompatible rewrite on `main` — it is now only a parser installer and query provider. The old `master` branch is locked and incompatible with Neovim 0.12's updated `iter_matches` API (captures now return `TSNode[]` instead of `TSNode`), causing crashes on `.md` files with fenced code blocks.

## Changes

### `lua/user/plugins/init.lua`

- Set `branch = 'main'` on the nvim-treesitter spec
- Set `lazy = false` (required by new plugin — does not support lazy-loading)
- Keep `build = ':TSUpdate'`
- Remove `nvim-treesitter-textobjects` and `nvim-ts-context-commentstring` from dependencies

### `lua/user/treesitter.lua`

Full rewrite. Old `configs.setup {}` API is gone.

```lua
require('nvim-treesitter').setup {}

require('nvim-treesitter').install {
  'lua', 'markdown', 'markdown_inline', 'bash', 'python',
  'dockerfile', 'gitignore', 'go', 'gomod', 'make',
  'sql', 'yaml', 'comment', 'diff', 'html',
  'javascript', 'json', 'regex',
}
```

### `lua/user/autocommands.lua`

Add a `FileType` autocommand to the existing `custom_autocmd_grp` group:

- Calls `vim.treesitter.start()` to enable highlighting (replaces `highlight.enable = true`)
- Sets `indentexpr` to `v:lua.require'nvim-treesitter'.indentexpr()` (replaces `indent.enable = true`)
- Excludes Python from indentexpr (matches existing `indent.disable = { 'python' }`)

## What Does Not Change

- `autopairs.lua` — `check_ts = true` works as long as parsers are present
- `comment.lua` — already has no `pre_hook`, no change needed
- All LSP, DAP, telescope, and other configs — unaffected

## Out of Scope

- `nvim-treesitter-textobjects` — deferred, user rarely used these mappings
- `ts-comments.nvim` — deferred, can be added if context-aware commenting is missed
