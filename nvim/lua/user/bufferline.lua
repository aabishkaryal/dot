local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  print('bufferline not found')
  return
end

bufferline.setup {
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = 'bdelete! %d',
    right_mouse_command = 'bdelete! %d',
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    separator_style = 'slant',
    modified_icon = '●',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    },
    color_icons = true,
    enforce_regular_tabs = true,
    always_show_bufferline = false,
    auto_toggle_bufferline = true,
    show_buffer_close_icons = false,
    show_duplicate_prefix = true,
  },
  -- No manual `highlights` override: let bufferline derive its colors from
  -- the active colorscheme. The old override wired the active tab to raw
  -- TabLineSel (a saturated accent color) and a legacy LSP highlight group
  -- that no longer resolves, which is what made the tab bar look mismatched.
}
