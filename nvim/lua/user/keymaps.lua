-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = {
  silent = true
}

local custom_keymaps_grp = vim.api.nvim_create_augroup('custom_keymaps', {
  clear = true
})

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better screen navigatio
keymap('n', '<leader>md', '<C-d>zz', opts)
keymap('n', '<leader>mu', '<C-u>zz', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<S-Up>', '<cmd>resize -2<CR>', opts)
keymap('n', '<S-Down>', '<cmd>resize +2<CR>', opts)
keymap('n', '<S-Left>', '<cmd>vertical resize -2<CR>', opts)
keymap('n', '<S-Right>', '<cmd>vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', '<cmd>bnext<CR>', opts)
keymap('n', '<S-h>', '<cmd>bprevious<CR>', opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Close buffers
keymap('n', '<S-q>', '<cmd>bdelete! | bnext<CR>', opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Plugins --

-- NvimTree
local status_ok_nt = pcall(require, "nvim-tree")
if status_ok_nt then
  keymap('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
  keymap('n', '<leader>o', '<cmd>NvimTreeFocus<CR>', opts)
end

-- Telescope
local status_ok_tel = pcall(require, "telescope")
if status_ok_tel then
  keymap("n", "<leader>fd", "<cmd>Telescope diagnostics initial_mode=normal<CR>", opts)
  keymap("n", "<leader>fk", "<cmd>Telescope keymaps initial_mode=normal<CR>", opts)

  keymap("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", opts)
  keymap("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", opts)
  keymap("n", "<leader>fb", "<cmd>Telescope buffers initial_mode=normal sort_mru=true<CR>", opts)
end

-- Comment
local status_ok_co = pcall(require, "Comment")
if status_ok_co then
  keymap('n', '<leader>/', '<cmd>lua require(\'Comment.api\').toggle.linewise.current()<CR>', opts)
  keymap('x', '<leader>/', '<esc><cmd>lua require(\'Comment.api\').toggle.linewise(vim.fn.visualmode())<CR>', opts)
end
-- -- DAP
-- keymap('n', '<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<cr>', opts)
-- keymap('n', '<leader>dc', '<cmd>lua require\'dap\'.continue()<cr>', opts)
-- keymap('n', '<leader>di', '<cmd>lua require\'dap\'.step_into()<cr>', opts)
-- keymap('n', '<leader>do', '<cmd>lua require\'dap\'.step_over()<cr>', opts)
-- keymap('n', '<leader>dO', '<cmd>lua require\'dap\'.step_out()<cr>', opts)
-- keymap('n', '<leader>dr', '<cmd>lua require\'dap\'.repl.toggle()<cr>', opts)
-- keymap('n', '<leader>dl', '<cmd>lua require\'dap\'.run_last()<cr>', opts)
-- keymap('n', '<leader>du', '<cmd>lua require\'dapui\'.toggle()<cr>', opts)
-- keymap('n', '<leader>dt', '<cmd>lua require\'dap\'.terminate()<cr>', opts)

-- vim.api.nvim_create_autocmd({
--     'FileType'
-- }, {
--     pattern = {
--         'go'
--     },
--     group = custom_keymaps_grp,
--     callback = function(args)
--         keymap('n', '<leader>dgt', '<cmd>lua require(\'dap-go\').debug_test() <CR>', {
--             buffer = args.buf
--         })
--         keymap('n', '<leader>dgl', '<cmd>lua require(\'dap-go\').debug_last_test()<CR>', {
--             buffer = args.buf
--         })
--     end,
--     desc = 'set custom keymaps for go files'
-- })

-- -- Lsp
-- keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', opts)
