local nvim_lint_status_ok, lint = pcall(require, "lint")
if not nvim_lint_status_ok then
	print("lint not found")
	return
end

lint.linters_by_ft = {
	go = { "golangcilint" },
	python = {},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
