-- Autocommands configuration
local M = {}

-- Create an autocommand group for adding header guards
M.setup_header_guards = function()
  local group = vim.api.nvim_create_augroup('AddHeaderGuards', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.h',
    group = group,
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local guard_macro = string.upper(vim.fn.fnamemodify(filename, ':t:r') .. '_H')

      -- Check if the file already has the guards
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local has_guards = false
      for _, line in ipairs(lines) do
        if line:match('#ifndef ' .. guard_macro) or line:match('#define ' .. guard_macro) or line:match '#endif' then
          has_guards = true
          break
        end
      end

      if not has_guards then
        -- Insert the guards at the beginning and end of the file
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {
          '#ifndef ' .. guard_macro,
          '#define ' .. guard_macro,
          '',
        })
        table.insert(lines, '#endif')
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
      end
    end,
  })
end

-- Setup Neotree autoopen
M.setup_neotree = function()
  local group = vim.api.nvim_create_augroup('neotree_autoopen', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
      -- Add your Neotree autoopen logic here
    end,
  })
end

-- Initialize all autocommands
M.setup = function()
  M.setup_header_guards()
  M.setup_neotree()
end

return M
