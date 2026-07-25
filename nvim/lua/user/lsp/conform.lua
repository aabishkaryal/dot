local status_ok, conform = pcall(require, "conform")
if not status_ok then
  print "conform not found"
  return
end

conform.setup {
  formatters_by_ft = {
    go = { "gofumpt", "goimports" },
    lua = { "stylua" },
    zig = { "zigfmt" },
    odin = { "odinfmt" },
  },
  -- Single format-on-save path (conform installs its own BufWritePre).
  -- Do not also create a BufWritePre that calls conform.format — that runs twice.
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
    -- Suppress UI notifications on failure; still writes to conform.log
    quiet = true,
  },
}
