local status_ok, illuminate = pcall(require, 'illuminate')
if not status_ok then
  print('vim-illuminate not found')
  return
end

vim.g.Illuminate_ftblacklist = {
  'alpha',
  'NvimTree'
}

illuminate.configure {
  providers = {
    'lsp',
    'treesitter',
    'regex'
  },
  delay = 200,
  filetypes_denylist = {
    'dirvish',
    'fugitive',
    'alpha',
    'NvimTree',
    'packer',
    'neogitstatus',
    'Trouble',
    'lir',
    'Outline',
    'spectre_panel',
    'toggleterm',
    'DressingSelect',
    'TelescopePrompt'
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = true
}
