local status_ok, icons = pcall(require, "nvim-web-devicons")
if not status_ok then
  print('nvim-web-dev-icons not found')
  return
end

icons.setup {
  enabled = vim.g.icons_enabled,
  override = {
    info = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Information",
    },
  },
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true,
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    [".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
    ["dockerfile"] = { icon = "", color = "#0088B3", name = "Dockerfile" },
  },
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ["log"] = { icon = "", color = "#81e043", name = "Log" },
    ["Dockerfile"] = { icon = "", color = "#0088B3", name = "Dockerfile" },
  },
}
