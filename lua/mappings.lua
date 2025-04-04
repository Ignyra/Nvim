-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>')

--Go to previous buffer, for example, when "going to destination/defintion"
vim.api.nvim_set_keymap('n', '<leader>b', '<C-o>', { desc = "Move Back to previous Buffer"})

--Moving between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Execute
vim.keymap.set('n', ';', ':', { desc = 'Excute Command' })

--Terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_set_keymap('n', '<Leader>tt', ':tabnew | terminal<CR>', { desc = "Opens a terminal in a new tab"})

vim.keymap.set('n', '<tab>', '<C-PageUp>', {desc = 'Move between tabs'})


vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
