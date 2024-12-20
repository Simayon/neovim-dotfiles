-- Set fill characters for the statusline
vim.opt.fillchars = {
  stl = ' ',
  stlnc = ' ',
}

local function check_insert_mode()
  return vim.fn.mode() == 'i'
end

local function format_mode_icon()
  local mode_map = {
    n = 'N', -- Normal mode icon
    i = 'I', -- Insert mode icon
    v = 'V', -- Visual mode icon
    V = '-V-', -- Visual line mode icon
  }
  return mode_map[vim.fn.mode()] or ''
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'horizon',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            'progress',
            cond = function()
              return not check_insert_mode()
            end,
          },
          {
            'mode',
            icons_enabled = true,
            cond = check_insert_mode,
            fmt = format_mode_icon,
          },
        },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = {
          {
            function()
              return '%='
            end,
          },
          {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            newfile_status = true,
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
            padding = { left = 1, right = 1 },
          },
        },
        lualine_x = {
          {
            function()
              return vim.fn.wordcount().words .. ' words'
            end,
            cond = is_markdown,
          },
        },
        lualine_y = {},
        lualine_z = { {
          "os.date('%x')",
          "require'lsp-status'.status()",
        } },
      },
      inactive_sections = {
        lualine_a = nil,
        lualine_b = nil,
        lualine_c = {
          'Nothing',
        },
        lualine_x = nil,
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
