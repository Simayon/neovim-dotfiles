return {
  'mbbill/undotree',
  keys = { { '<leader>u', '<CMD>UndotreeToggle<CR>', desc = '[O]pen [U]ndotree' } },
  config = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
