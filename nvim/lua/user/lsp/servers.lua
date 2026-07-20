-- LSP servers are expected to be installed on the system (brew/go/npm/...),
-- not managed by any in-editor installer. Add a name here and make sure the
-- binary is on PATH. Run :LspServers to check what's missing.
local servers = {
	"bashls",
	"docker_language_server",
	"gopls",
	"lua_ls",
	"zls",
	"ols",
	"pylsp",
	"ruff",
}

for _, server_name in ipairs(servers) do
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

local function check_missing_servers()
	local missing = {}
	for _, server_name in ipairs(servers) do
		local ok, config = pcall(function()
			return vim.lsp.config[server_name]
		end)
		local cmd = ok and config and config.cmd or nil
		if type(cmd) == "table" and vim.fn.executable(cmd[1]) ~= 1 then
			table.insert(missing, string.format("%s (%s): not found on PATH", server_name, cmd[1]))
		end
	end

	if #missing > 0 then
		vim.notify("LSP servers missing:\n" .. table.concat(missing, "\n"), vim.log.levels.WARN)
	else
		vim.notify("All enabled LSP servers found", vim.log.levels.INFO)
	end
end

vim.schedule(check_missing_servers)

vim.api.nvim_create_user_command("LspServers", check_missing_servers, {
	desc = "Check which enabled LSP servers are missing their binary on PATH",
})
