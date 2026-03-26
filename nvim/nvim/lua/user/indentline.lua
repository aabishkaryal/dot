local status_ok, indent_blankline = pcall(require, 'ibl')
if not status_ok then
  print('indentline not found')
  return
end

indent_blankline.setup {
  exclude = {
    filetypes = {
      'help',
      'lspinfo',
      'packer',
      'checkhealth',
      'help',
      'man',
      'gitcommit',
      'TelescopePrompt',
      'TelescopeResults',
      ''
    }
  },
  scope = {
    enabled = true
  }
}
