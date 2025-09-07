vim.api.nvim_create_user_command("LI", ":LspInfo", {})

vim.api.nvim_create_user_command("CA", ":lua require(\"telescope\").code_actions()", {})

-- Debug LSP servers for current buffer
vim.api.nvim_create_user_command("LspDebug", function()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	print("=== LSP Debug Info ===")
	print("Active clients for current buffer: " .. #clients)
	
	for _, client in pairs(clients) do
		print("• " .. client.name .. " (ID: " .. client.id .. ")")
		print("  Root: " .. (client.config.root_dir or "none"))
	end
	
	if #clients > 1 then
		print("⚠️  Multiple servers detected! Use :LspStop to stop duplicates.")
	end
end, {})
