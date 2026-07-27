-- Dual rulers at cols 80 (soft) and 100 (hard).
-- Built-in colorcolumn only has one ColorColumn highlight, so we use
-- virt-column.nvim for two theme-derived colors that re-sync on ColorScheme.

local function hl_hex(name, attr)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok or not hl or not hl[attr] then
    return nil
  end
  return string.format('#%06x', hl[attr])
end

local function blend(fg, bg, alpha)
  local function parse(hex)
    hex = hex:gsub('#', '')
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
  end
  local fr, fg_, fb = parse(fg)
  local br, bg_, bb = parse(bg)
  local r = math.floor(fr * alpha + br * (1 - alpha) + 0.5)
  local g = math.floor(fg_ * alpha + bg_ * (1 - alpha) + 0.5)
  local b = math.floor(fb * alpha + bb * (1 - alpha) + 0.5)
  return string.format('#%02x%02x%02x', r, g, b)
end

local function apply_theme_colors()
  local normal_bg = hl_hex('Normal', 'bg') or '#1a1b26'
  local soft_src = hl_hex('Comment', 'fg')
    or hl_hex('LineNr', 'fg')
    or '#565f89'
  local hard_src = hl_hex('DiagnosticWarn', 'fg')
    or hl_hex('WarningMsg', 'fg')
    or soft_src

  -- Soft (80): faint wash of Comment into the background.
  -- Hard (100): stronger wash of DiagnosticWarn — still subtle, not neon.
  vim.api.nvim_set_hl(0, 'VirtColumnSoft', { fg = blend(soft_src, normal_bg, 0.28) })
  vim.api.nvim_set_hl(0, 'VirtColumnHard', { fg = blend(hard_src, normal_bg, 0.55) })
end

local status_ok, virt_column = pcall(require, 'virt-column')
if not status_ok then
  print('virt-column not found')
  return
end

-- Avoid double-drawing with the built-in colorcolumn highlight.
vim.opt.colorcolumn = ''

virt_column.setup({
  char = '│',
  virtcolumn = '80,100',
  highlight = { 'VirtColumnSoft', 'VirtColumnHard' },
})

apply_theme_colors()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('user_colorcolumn', { clear = true }),
  callback = function()
    -- Schedule so we run after the colorscheme finishes applying its own highlights.
    vim.schedule(apply_theme_colors)
  end,
})
