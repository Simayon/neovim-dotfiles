-- Lazy.nvim
return {
  'TobinPalmer/Tip.nvim',
  event = 'VimEnter',
  init = function()
    -- Default config
    --- @type Tip.config
    require('tip').setup {
      seconds = 6,
      title = 'Tip!',
      url = 'https://vtip.43z.one', -- Or https://vimiscool.tech/neotip
    }
  end,
}
