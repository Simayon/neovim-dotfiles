return {
  'ojroques/vim-oscyank',
  branch = 'main',
  config = function()
    -- Key mappings for OSCYank

    -- Optional configurations
    vim.g.oscyank_max_length = 0 -- No limit on selection length
    vim.g.oscyank_silent = 0 -- Show success messages on copy
    vim.g.oscyank_trim = 0 -- Do not trim whitespace when copying

    -- which-key integration
    local wk = require 'which-key'
    wk.add {
      {
        '<leader>c',
        '<Plug>OSCYankOperator',
        desc = 'Copy to clipboard (OSC52)',
        mode = 'n',
      },
      {
        '<leader>cl',
        '<Plug>OSCYankLine',
        { remap = true, desc = 'Copy current line to clipboard' },
        mode = 'n',
      },
      {
        '<leader>c',
        '<Plug>OSCYankVisual',
        { desc = 'Copy selection to clipboard' },
        mode = 'v',
      },
    }
  end,
}
