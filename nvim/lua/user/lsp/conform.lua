local status_ok, conform = pcall(require, "conform")
if not status_ok then
  print "conform not found"
  return
end

conform.setup {
  formatters_by_ft = {
    go = { "gofumpt", "goimports" },
    lua = { "stylua" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format { bufnr = args.buf }
  end,
})
