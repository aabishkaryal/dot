local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print('null-ls not found')
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

local path = "/opt/homebrew/bin/python3"
local conda_path = os.getenv("CONDA_PREFIX")
if conda_path then
  path = conda_path .. "/bin/python"
end

null_ls.setup {
  debug = false,
  on_attach = require("user.lsp.handlers").on_attach,
  sources = {
    code_actions.gomodifytags,
    code_actions.shellcheck,

    completion.luasnip,

    formatting.gofumpt,
    formatting.goimports,
    formatting.golines,
    formatting.rustfmt,
    formatting.lua_format.with {
      extra_args = {
        "-c",
        vim.fn.expand("~/.config/LuaFormatter/config.yaml"),
      },
    },
    formatting.beautysh,

    diagnostics.shellcheck,
    diagnostics.golangci_lint,
    diagnostics.hadolint,
    diagnostics.todo_comments,
  },
}
