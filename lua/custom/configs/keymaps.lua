-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "UGH!!! Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "UGH!!! Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "UGH!!! Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "UGH!!! Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep the line centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep the line centered' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Keep the line centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Keep the line centered' })

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Change the file into an executable' })
