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

mason_lspconfig.setup({
	ensure_installed = {
		"bashls",
		"dockerls",
		"docker_compose_language_service",
		"gopls",
		"lua_ls",
	},
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	print "lspconfig not found"
	return
end

local lsp_handlers = require "user.lsp.handlers"

local servers = {
	"bashls",
	"dockerls",
	"docker_compose_language_service",
	"gopls",
	"lua_ls",
}

for _, server_name in pairs(servers) do
	local opts = {
		on_attach = lsp_handlers.on_attach,
		capabilities = lsp_handlers.capabilities,
		single_file_support = true,  -- Enable single file support
	}

	local require_ok, server_opts = pcall(require, "user.lsp.settings." .. server_name)
	if require_ok then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end

	-- Prevent duplicate servers by checking if already configured
	if not lspconfig[server_name].manager then
		lspconfig[server_name].setup(opts)
	end
end
