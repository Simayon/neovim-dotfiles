return {
  'folke/snacks.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {},
  config = function()
    local Snacks = require('snacks')
    
    -- Git related keybindings
    vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
    vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git Blame Line' })
    vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
    vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
    vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = 'Lazygit Log (cwd)' })
  end,
}
