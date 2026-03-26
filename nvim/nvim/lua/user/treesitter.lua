local ts_ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
if not ts_ok then
	print('nvim-treesitter not found')
	return
end

nvim_treesitter.setup()

local ensure_installed = {
	'lua',
	'markdown',
	'markdown_inline',
	'bash',
	'python',
	'dockerfile',
	'gitignore',
	'go',
	'gomod',
	'make',
	'sql',
	'yaml',
	'comment',
	'diff',
	'html',
	'javascript',
	'json',
	'regex',
}

-- Install missing parsers
local installed = nvim_treesitter.get_installed()
local to_install = {}
for _, lang in ipairs(ensure_installed) do
	if not vim.tbl_contains(installed, lang) then
		table.insert(to_install, lang)
	end
end
if #to_install > 0 then
	nvim_treesitter.install(to_install)
end

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})