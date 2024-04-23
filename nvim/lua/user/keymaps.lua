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
keymap('n', '<S-Up>', ':resize -2<CR>', opts)
keymap('n', '<S-Down>', ':resize +2<CR>', opts)
keymap('n', '<S-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<S-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Close buffers
keymap('n', '<S-q>', '<cmd>Bdelete!<CR>', opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Sync to system clipboard with C-c and C-v
keymap('', '<A-c>', '+y', opts)
keymap('', '<A-v>', '+p', opts)

-- Insert --
-- P}ress jk fast to enter normal mode
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- -- Plugins --

-- -- NvimTree
-- keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
-- keymap('n', '<leader>o', ':NvimTreeFocus<CR>', opts)

-- -- Telescope
-- local status_ok = pcall(require, 'telescope')
-- if status_ok then
--     local builtin = require('telescope.builtin')
--     keymap('n', '<leader>sd', builtin.diagnostics, opts)
--     keymap('n', '<leader>sk', builtin.keymaps, opts)
-- end
-- keymap('n', '<leader>ff', ':Telescope find_files hidden=true<CR>', opts)
-- keymap('n', '<leader>ft', ':Telescope live_grep<CR>', opts)
-- keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- -- Git
-- keymap('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)

-- -- Comment
-- keymap('n', '<leader>/', '<cmd>lua require(\'Comment.api\').toggle.linewise.current()<CR>', opts)
-- keymap('x', '<leader>/', '<esc><cmd>lua require(\'Comment.api\').toggle.linewise(vim.fn.visualmode())<CR>', opts)

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
