local custom_autocmd_grp = vim.api.nvim_create_augroup("custom_autocmd",
  { clear = true })

-- Close certain filetypes with `q`
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.opt_local.buflisted = false
  end,
  group = custom_autocmd_grp,
})

-- Enable spellcheck for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = custom_autocmd_grp,
})
-- resizes the current window to be equal in size to the other windows in the tab page.
vim.api.nvim_create_autocmd({ "VimResized" }, {
  command = "tabdo wincmd =",
  group = custom_autocmd_grp,
})

-- highlight text when yanked
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
  group = custom_autocmd_grp,
})

-- configure vim-illuminate highlight group
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  -- TODO: check LspReferenceText after lsp configurations
  command = "hi link illuminatedWord LspReferenceText",
  group = custom_autocmd_grp,
})

-- stop vim-illuminate if file has more than 3000 lines
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 3000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
  group = custom_autocmd_grp,
})

-- show diagnostics (if available) when cursor is over word
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  command = "lua vim.diagnostic.open_float(nil, {focus=false})",
  group = custom_autocmd_grp,
})

-- register custom filetypes
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
