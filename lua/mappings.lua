local cmd = function (Command)
  return function ()
    vim.cmd(Command)
  end
end



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

--Moving v-blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move Selected Block Up"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move Selected Block Down"})

--Execute
vim.keymap.set('n', ';', ':', { desc = 'Excute Command' })

--Terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<Leader>tt', cmd('tabnew | terminal'), { desc = "Opens a terminal in a new tab"})

--vim.keymap.set('n', '<tab>', '<C-PageUp>', {desc = 'Move between tabs'})
vim.keymap.set('n', '<tab>', cmd("bn"), {desc = 'Move between buffers'})
vim.keymap.set('n', '<S-tab>', cmd("bp"), {desc = 'Move between buffers'})

vim.keymap.set('n', 'qd<leader>', cmd('bd!'), {desc = 'Close buffer without saving/applies to terminal too'})
vim.keymap.set('n', 'q<leader>', cmd('bd'), {desc = 'Close buffer if saved'})

--Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Search and Replace All"})
vim.keymap.set("v", "<leader>s", [[:<C-u>let @v=escape(getreg('v'), '\/.*$^~[]<>')<CR>gv"vy:%s#<C-r>v#<C-r>v#gI<Left><Left><Left>]], { desc = "Search and Replace All/ Visual Selection" })

vim.keymap.set("i", "jj", "<ESC>", {desc = "Exit Insert Mode"})


vim.keymap.set('n', '<leader>t', ':tabnew ', { desc = "Opens a new tab"})

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--f for fun
vim.keymap.set("n", '<leader>f', cmd('CellularAutomaton scramble'), {desc = "CellularAutomaton Fun Plugin"})
vim.keymap.set("n", '<leader>ff', cmd('CellularAutomaton make_it_rain'), {desc = "CellularAutomaton Fun Plugin"})
vim.keymap.set("n", '<leader>fff', cmd('CellularAutomaton game_of_life'), {desc = "CellularAutomaton Fun Plugin"})

vim.keymap.set("n", '<leader>su', cmd('Sudoku'), {desc = "Sudoku Game"})
vim.keymap.set("n", '<leader>jk', cmd('BlackJackNewGame'), {desc = "BlackJack Game"})


