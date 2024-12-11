return {
  'folke/snacks.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    dim = {
      ---@class snacks.dim.Config
      {
        ---@type snacks.scope.Config
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
        ---@type snacks.animate.Config|{enabled?: boolean}
        ---    animate = {
        enabled = vim.fn.has 'nvim-0.10' == 1,
        easing = 'inOutQuad', -- Try different easing functions
        duration = {
          step = 10, -- Reduced from 20, makes animation quicker
          total = 150, -- Reduced from 300, makes animation more snappy
        },
        filter = function(buf)
          return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ''
        end,
      },
    },
  },
  -- Keybindings
  keys = {
    { '<leader>de', '<cmd>lua Snacks.dim.enable()<CR>', desc = 'Enable Dim' },
    { '<leader>dd', '<cmd>lua Snacks.dim.disable()<CR>', desc = 'Disable Dim' },
  },

  config = function()
    local Snacks = require 'snacks'

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

    -- which-key integration
    local wk = require('which-key')
    wk.register({
      d = {
        name = "Dimming",
        e = {"<cmd>lua Snacks.dim.enable()<CR>", "Enable Dim"},
        d = {"<cmd>lua Snacks.dim.disable()<CR>", "Disable Dim"},
      },
    }, { prefix = "<leader>" })
  end,
}
