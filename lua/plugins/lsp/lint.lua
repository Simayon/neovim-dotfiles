return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      
      -- Check if markdownlint is available
      local function is_markdownlint_available()
        local handle = io.popen('command -v markdownlint')
        if handle then
          local result = handle:read('*a')
          handle:close()
          return result and result:len() > 0
        end
        return false
      end

      lint.linters_by_ft = {}
      
      -- Only enable markdownlint if it's available
      if is_markdownlint_available() then
        lint.linters_by_ft.markdown = { 'markdownlint' }
      end

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
