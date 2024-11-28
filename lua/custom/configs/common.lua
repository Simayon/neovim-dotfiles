-- Common configuration settings used across multiple plugins
local M = {}

-- UI related settings
M.ui = {
  -- Common border style for floating windows
  border = 'rounded',
  
  -- Common highlight groups
  highlights = {
    search = 'Search',
    error = 'DiagnosticError',
    warn = 'DiagnosticWarn',
    info = 'DiagnosticInfo',
    hint = 'DiagnosticHint',
  },
  
  -- Icons used across different plugins
  icons = {
    diagnostics = {
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = ' ',
    },
    git = {
      added = '+',
      modified = '~',
      removed = '-',
    },
    kinds = {
      File = '',
      Module = '',
      Namespace = '',
      Package = '',
      Class = '',
      Method = '',
      Property = '',
      Field = '',
      Constructor = '',
      Enum = '',
      Interface = '',
      Function = '',
      Variable = '',
      Constant = '',
      String = '',
      Number = '',
      Boolean = '',
      Array = '',
      Object = '',
      Key = '',
      Null = '',
      EnumMember = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '',
    },
  },
}

-- Common plugin settings
M.plugin_defaults = {
  -- Default timeouts
  format_timeout = 3000,
  completion_timeout = 500,
  
  -- Default file patterns to ignore
  ignore_patterns = {
    '%.git/',
    'node_modules/',
    'target/',
    'vendor/',
  },
}

return M
