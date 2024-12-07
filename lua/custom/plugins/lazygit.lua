return {
  'folke/snacks.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {},
  config = function()
    local Snacks = require('snacks')
    
    -- Git related keybindings
    vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = '[G]it [B]rowse' })
    vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = '[G]it [B]lame Line' })
    vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = '[G]it [F]ile History' })
    vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = '[G]it Open Lazy[G]it' })
    vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = '[G]it [L]og' })
  end,
}
