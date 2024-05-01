local custom_autocmd_grp = vim.api.nvim_create_augroup("custom_autocmd",
	{ clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd [[ nnoremap <silent> <buffer> q :close<CR> set nobuflisted ]]
	end,
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	command = "tabdo wincmd =",
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
	end,
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	command = "hi link illuminatedWord LspReferenceText",
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd "IlluminatePauseBuf"
		end
	end,
	group = custom_autocmd_grp,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	command = "lua vim.diagnostic.open_float(nil, {focus=false})",
	group = custom_autocmd_grp,
})

local filetypes = {
	gitignore = { "*.dockerignore" },
	env = { ".env.*", ".env" },
}
for filetype, patterns in pairs(filetypes) do
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = custom_autocmd_grp,
		command = "setfiletype " .. filetype,
		pattern = patterns,
	})
end
