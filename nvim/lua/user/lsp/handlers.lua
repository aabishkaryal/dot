local M = {}

M.setup = function()
	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
		update_in_insert = true,
		underline = true, -- enable underlines for proper error highlighting
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- Set up capabilities and handlers for all LSP servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_cmp_ok then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	vim.lsp.config("*", {
		capabilities = capabilities,
		handlers = {
			["textDocument/hover"] = function(err, result, ctx, config)
				vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
			end,
			["textDocument/signatureHelp"] = function(err, result, ctx, config)
				vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
			end,
		},
	})

	-- Buffer-local LSP maps (attached clients only). Primary home is <leader>l.
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, {
					buffer = bufnr,
					noremap = true,
					silent = true,
					desc = desc,
				})
			end

			-- Navigation (all lowercase under <leader>l)
			map("n", "<leader>ld", vim.lsp.buf.definition, "Definition")
			map("n", "<leader>lc", vim.lsp.buf.declaration, "Declaration")
			map("n", "<leader>lp", vim.lsp.buf.implementation, "Implementation")
			map("n", "<leader>lu", vim.lsp.buf.references, "Usages / references")
			map("n", "<leader>ly", vim.lsp.buf.type_definition, "Type definition")
			map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")

			-- Actions
			map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
			map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
			map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature help")

			-- Diagnostics
			map("n", "<leader>ll", vim.diagnostic.open_float, "Line diagnostics")
			map("n", "<leader>lj", function()
				vim.diagnostic.goto_next({ buffer = 0 })
			end, "Next diagnostic")
			map("n", "<leader>lk", function()
				vim.diagnostic.goto_prev({ buffer = 0 })
			end, "Prev diagnostic")
			map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostics → loclist")

			-- Meta
			map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP info")
			map("n", "<leader>lm", "<cmd>LspServers<cr>", "Missing LSP servers")
		end,
	})
end

return M
