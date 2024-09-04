local colorscheme = 'rose-pine'

return {
  'rose-pine/neovim',
  as = { 'rose-pine' },
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    variant = 'auto', -- auto, main, moon, or dawn
    dark_variant = 'main', -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },
  },
  config = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme(colorscheme)

    --Customize highlights
    vim.cmd.hi 'Comment gui=none'
  end,
}
