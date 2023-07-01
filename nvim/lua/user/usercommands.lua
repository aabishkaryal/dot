vim.api.nvim_create_user_command("LI", ":LspInfo", {})
vim.api.nvim_create_user_command("NI", ":NullLsInfo", {})

vim.api.nvim_create_user_command("CA", ":lua require(\"telescope\").code_actions()", {})
