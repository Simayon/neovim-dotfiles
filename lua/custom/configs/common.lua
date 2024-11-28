---@class CommonConfig
---@field ui table UI related settings
---@field plugin_defaults table Common plugin settings
local M = {}

---@class UIConfig
---@field border string Common border style for floating windows
---@field highlights table Common highlight groups
---@field icons table Icons used across different plugins
M.ui = {
  border = 'rounded',
  
  highlights = {
    search = 'Search',
    error = 'DiagnosticError',
    warn = 'DiagnosticWarn',
    info = 'DiagnosticInfo',
    hint = 'DiagnosticHint',
  },
  
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

---@class PluginDefaults
---@field format_timeout number Default timeout for formatting operations
---@field completion_timeout number Default timeout for completion operations
---@field ignore_patterns string[] Default file patterns to ignore
M.plugin_defaults = {
  format_timeout = 3000,
  completion_timeout = 500,
  
  ignore_patterns = {
    '%.git/',
    'node_modules/',
    'target/',
    'vendor/',
  },
}

---Get UI configuration with error handling
---@return table
function M.get_ui_config()
  local ok, config = pcall(function()
    return vim.deepcopy(M.ui)
  end)
  if not ok then
    vim.notify('Error loading UI config, using defaults', vim.log.levels.WARN)
    return { border = 'rounded' }
  end
  return config
end

---Get plugin defaults with error handling
---@return table
function M.get_plugin_defaults()
  local ok, config = pcall(function()
    return vim.deepcopy(M.plugin_defaults)
  end)
  if not ok then
    vim.notify('Error loading plugin defaults, using basic defaults', vim.log.levels.WARN)
    return { format_timeout = 3000, completion_timeout = 500 }
  end
  return config
end

return M
