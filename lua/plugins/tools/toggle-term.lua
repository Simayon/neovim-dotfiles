return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    local toggleterm = require 'toggleterm'

    toggleterm.setup {
      open_mapping = [[<c-\>]],
      hide_number = true,
      start_in_insert = true,
      direction = 'float', -- horizontal | vertical | float | tab
      shell = 'zsh', -- or "bash", "fish", "pwsh", etc.
    }
  end,
}
