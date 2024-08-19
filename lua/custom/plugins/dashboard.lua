local quotes = {
  '"The only way to do great work is to love what you do" - Steve Jobs',
  '"Life is what happens when you\'re busy making other plans" - John Lennon',
  '"The future belongs to those who believe in the beauty of their dreams" - Eleanor Roosevelt',
  '"Success is not final, failure is not fatal: it is the courage to continue that counts" - Winston Churchill',
  '"The only impossible journey is the one you never begin" - Tony Robbins',
}

-- Function to get a random quote
local function get_random_quote()
  math.randomseed(os.time()) -- Seed the random number generator
  return quotes[math.random(#quotes)]
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      theme = 'hyper',
      config = {
        center = {},

        week_header = {
          enable = true,
        },

        disable_move = true, -- boolean default is false disable move key

        shortcut = {
          {
            icon = '󰊳 ',
            icon_hl = '@variable',
            desc = 'Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
        },
        footer = function()
          local quote = get_random_quote()
          return {
            '',
            '',
            '',
            '',
            '',
            '',
            quote,
          }
        end,
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
