local servers = {
  "bash-language-server",
  "beautysh",
  "checkmake",
  "codespell",
  "delve",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "go-debug-adapter",
  "gofumpt",
  "golangci-lint@v1.64.8",
  "golines",
  "gomodifytags",
  "gopls",
  "gotests",
  "hadolint",
  "lua-language-server",
  "luacheck",
  "luaformatter",
  "markdown-toc",
  "shellcheck",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
  ensure_installed = servers,
  automatic_installation = true,
}

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
  print "mason not found"
  return
end

mason.setup(settings)

local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_mason_lspconfig then
  print "mason-lspconfig not found"
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  print "lspconfig not found"
  return
end

local lsp_handlers = require "user.lsp.handlers"
mason_lspconfig.setup_handlers {
  function(server)
    local opts = {
      on_attach = lsp_handlers.on_attach,
      capabilities = lsp_handlers.capabilities,
    }
    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
    lspconfig[server].setup(opts)
  end,
}
