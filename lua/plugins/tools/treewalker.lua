return {
  'aaronik/treewalker.nvim',
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
    highlight_duration = 250, -- How long should above highlight last (in ms)
  },
  config = function(_, opts)
    local wk = require 'which-key'
    
    -- Set up all keymaps
    local keymaps = {
      -- Original keymaps
      ['<C-n>'] = { ':Treewalker Down<CR>', 'Next Function' },
      ['<C-p>'] = { ':Treewalker Up<CR>', 'Prev Function' },
      ['<C-f>'] = { ':Treewalker Right<CR>', 'Next Symbol' },
      ['<C-b>'] = { ':Treewalker Left<CR>', 'Prev Symbol' },
      
      -- New additional keymaps
      ['<C-k>'] = { ':Treewalker Up<CR>', 'Move Up' },
      ['<C-j>'] = { ':Treewalker Down<CR>', 'Move Down' },
      ['<C-l>'] = { ':Treewalker Right<CR>', 'Move Right' },
      ['<C-h>'] = { ':Treewalker Left<CR>', 'Move Left' },
      
      -- Node swapping
      ['<C-S-j>'] = { ':Treewalker SwapDown<CR>', 'Swap Down' },
      ['<C-S-k>'] = { ':Treewalker SwapUp<CR>', 'Swap Up' },
      ['<C-S-l>'] = { ':TSTextobjectSwapNext @parameter.inner<CR>', 'Swap Next Parameter' },
      ['<C-S-h>'] = { ':TSTextobjectSwapPrevious @parameter.inner<CR>', 'Swap Prev Parameter' },
    }

    -- Register all keymaps with which-key
    for key, mapping in pairs(keymaps) do
      vim.keymap.set({ 'n', 'v' }, key, mapping[1], { 
        noremap = true, 
        silent = true,
        desc = mapping[2]
      })
    end

    -- Add which-key group
    wk.register({
      ['f'] = { name = '[S]yntax [N]avigation' },
    })
  end,
}
