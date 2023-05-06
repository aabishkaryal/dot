local servers = {
	"yamlls",
	"bash-language-server",
	"actionlint",
	"chrome-debug-adapter",
	"codelldb",
	"codespell",
	"cpplint",
	"css-lsp",
	"cssmodules-language-server",
	"delve",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"eslint_d",
	"go-debug-adapter",
	"gofumpt",
	"goimports",
	"golines",
	"gomodifytags",
	"gopls",
	"gotests",
	"hadolint",
	"html-lsp",
	"json-lsp",
	"jsonlint",
	"lua-language-server",
	"prettier",
	"protolint",
	"pyright",
	"rust-analyzer",
	"rustfmt",
	"spellcheck",
	"sql-formatter",
	"svelte-language-server",
	"tailwindcss-language-server",
	"typescript-language-server",
	"yaml-language-server",
	"yamllint",
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

require("mason").setup(settings)
local mason_lspconfig = require("mason-lspconfig")

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local lsp_handlers = require("user.lsp.handlers")
mason_lspconfig.setup_handlers {
	function(server)
		local opts = {
			on_attach = lsp_handlers.on_attach,
			capabilities = lsp_handlers.capabilities,
		}

		local require_ok, conf_opts = pcall(require,
			"user.lsp.settings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end

		lspconfig[server].setup(opts)
	end,
}
