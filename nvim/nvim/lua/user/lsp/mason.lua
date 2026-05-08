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
	ensure_installed = {
		"bash-language-server",
		"dockerfile-language-server",
		"docker-compose-language-service",
		"gopls",
		"lua-language-server",
	},
}

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
	print "mason not found"
	return
end

mason.setup(settings)

local servers = {
	"bashls",
	"dockerls",
	"docker_compose_language_service",
	"gopls",
	"lua_ls",
}

for _, server_name in pairs(servers) do
	local opts = {
		single_file_support = true,
	}

	local require_ok, server_opts = pcall(require, "user.lsp.settings." .. server_name)
	if require_ok then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end

	vim.lsp.config(server_name, opts)
end

vim.lsp.enable(servers)