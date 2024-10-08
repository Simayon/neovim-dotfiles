return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    local toggleterm = require 'toggleterm'

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      display_name = 'Lazy Git',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', { desc = '[T]oggle [L]azygit', noremap = true, silent = true })

    toggleterm.setup {
      open_mapping = [[<c-\>]],
      hide_number = true,
      start_in_insert = true,
      direction = 'horizontal', -- horizontal | vertical | float | tab
      shell = 'zsh', -- or "bash", "fish", "pwsh", etc.
    }
  end,
}
