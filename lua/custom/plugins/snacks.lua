return {
  'folke/snacks.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    dim = {
      scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
      },
      animate = {
        enabled = vim.fn.has 'nvim-0.10' == 1,
        easing = 'inOutQuad',
        duration = {
          step = 10,
          total = 150,
        },
        filter = function(buf)
          return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ''
        end,
      },
    },
  },
  config = function(_, opts)
    local Snacks = require 'snacks'

    -- Setup with opts
    Snacks.setup(opts)

    -- Git related keybindings
    vim.keymap.set('n', '<leader>gB', function()
      Snacks.gitbrowse()
    end, { desc = '[G]it [B]rowse' })
    vim.keymap.set('n', '<leader>gb', function()
      Snacks.git.blame_line()
    end, { desc = '[G]it [B]lame Line' })
    vim.keymap.set('n', '<leader>gf', function()
      Snacks.lazygit.log_file()
    end, { desc = '[G]it [F]ile History' })
    vim.keymap.set('n', '<leader>gg', function()
      Snacks.lazygit()
    end, { desc = '[G]it Open Lazy[G]it' })
    vim.keymap.set('n', '<leader>gl', function()
      Snacks.lazygit.log()
    end, { desc = '[G]it [L]og' })

    -- Dim keybindings
    vim.keymap.set('n', '<leader>de', function()
      Snacks.dim.enable()
    end, { desc = 'Enable Dim' })
    vim.keymap.set('n', '<leader>dd', function()
      Snacks.dim.disable()
    end, { desc = 'Disable Dim' })

    -- which-key integration
    local wk = require 'which-key'
    wk.add {
      { '<leader>d', group = 'Dimming' },
      {
        '<leader>dd',
        function()
          Snacks.dim.disable()
        end,
        desc = 'Disable Dim',
        mode = 'n',
      },
      {
        '<leader>de',
        function()
          Snacks.dim.enable()
        end,
        desc = 'Enable Dim',
        mode = 'n',
      },
    }
  end,
}
