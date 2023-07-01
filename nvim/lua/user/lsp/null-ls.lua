local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup {
	debug = false,
	on_attach = require("user.lsp.handlers").on_attach,
	sources = {
		code_actions.eslint,
		code_actions.gomodifytags,
		code_actions.shellcheck,
		code_actions.statix,
		completion.luasnip,

		formatting.buf,
		formatting.gofumpt,
		formatting.goimports,
		formatting.goimports_reviser,
		formatting.golines,
		formatting.prettier,
		formatting.rustfmt,
		formatting.sql_formatter,
		formatting.lua_format.with {
			extra_args = {
				"-c",
				vim.fn.expand("~/.config/LuaFormatter/config.yaml"),
			},
		},

		diagnostics.eslint,
		diagnostics.shellcheck,
		diagnostics.statix,
		diagnostics.buf,
		diagnostics.golangci_lint,
		diagnostics.dotenv_linter,
		diagnostics.hadolint,
		diagnostics.jsonlint,
		diagnostics.shellcheck,
		diagnostics.todo_comments,
		diagnostics.yamllint,
		diagnostics.zsh,
	},
}
