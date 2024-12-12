---@class AutoCommands
---@field setup_header_guards function
---@field setup_neotree function
---@field setup function
local M = {}

-- Error handling helper
---@param callback function
---@return function
local function with_error_handling(callback)
  return function(...)
    local ok, err = pcall(callback, ...)
    if not ok then
      vim.notify('Error in autocommand: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end
end

M.setup_markdown_hints = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      -- Disable inlay hints for markdown files
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(0, false)
      end
    end,
  })
end

---Create an autocommand group for adding header guards
---@return nil
M.setup_header_guards = function()
  local group = vim.api.nvim_create_augroup('AddHeaderGuards', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.h',
    group = group,
    callback = with_error_handling(function()
      -- Schedule heavy file operations
      vim.schedule(function()
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
      end)
    end),
  })
end

---Setup Neotree autoopen with deferred initialization
---@return nil
M.setup_neotree = function()
  local group = vim.api.nvim_create_augroup('neotree_autoopen', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = with_error_handling(function()
      -- Defer non-critical UI updates
      vim.defer_fn(function()
        -- Add your Neotree autoopen logic here
        if vim.bo.filetype ~= 'neo-tree' then
          vim.cmd 'Neotree show'
        end
      end, 100) -- 100ms delay
    end),
  })
end

---Initialize all autocommands with startup time profiling
---@return nil
M.setup = function()
  -- Profile startup time if requested
  if vim.env.NVIM_PROFILE then
    vim.cmd 'profile start profile.log'
    vim.cmd 'profile file *'
    vim.cmd 'profile func *'
  end

  M.setup_header_guards()
  M.setup_neotree()

  -- Stop profiling if it was started
  if vim.env.NVIM_PROFILE then
    vim.defer_fn(function()
      vim.cmd 'profile stop'
    end, 3000) -- Stop profiling after 3 seconds
  end
end

return M
