local colorscheme = 'dracula'

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  print('colorscheme couldn\'t be set')
  return
end
