return {
  'ojroques/vim-oscyank',
  branch = 'main',
  config = function()
    -- Key mappings for OSCYank
    vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator', { desc = 'Copy to clipboard (OSC52)' })
    vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true, desc = 'Copy current line to clipboard' })
    vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual', { desc = 'Copy selection to clipboard' })

    -- Optional configurations
    vim.g.oscyank_max_length = 0 -- No limit on selection length
    vim.g.oscyank_silent = 0 -- Show success messages on copy
    vim.g.oscyank_trim = 0 -- Do not trim whitespace when copying
  end,
}
