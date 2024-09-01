return {
  'SmiteshP/nvim-navbuddy',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  event = 'VeryLazy',
  cmd = 'Navbuddy',
  keys = { { '<leader>sn', '<CMD>Navbuddy<CR>', desc = '[S]earch [N]avbuddy' } },
  config = function()
    require('nvim-navbuddy').setup {
      use_default_mappings = true,
      lsp = {
        auto_attach = true,
      },
    }
  end,
}
