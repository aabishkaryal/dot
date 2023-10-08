local status_ok, starry = pcall(require, 'starry')
if not status_ok then
    return
end

local colorscheme = 'dracula'
vim.cmd.colorscheme(colorscheme)
