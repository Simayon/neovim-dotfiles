-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    filesystem = {
      window = {
        position = 'left',
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['\\'] = 'close_window',
          ['<BS>'] = 'navigate_up', -- Use backspace to go up a directory
          ['H'] = 'toggle_hidden', -- Toggle hidden files
          ['<2-LeftMouse>'] = 'open',
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['i'] = 'show_file_details',
          ['<C-g>'] = 'start_git',
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ['bd'] = 'buffer_delete',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
          ['oc'] = { 'order_by_created', nowait = false },
          ['od'] = { 'order_by_diagnostics', nowait = false },
          ['om'] = { 'order_by_modified', nowait = false },
          ['on'] = { 'order_by_name', nowait = false },
          ['os'] = { 'order_by_size', nowait = false },
          ['ot'] = { 'order_by_type', nowait = false },
        },
      },
    },
    commands = {
      start_git = function()
        vim.cmd ':Neotree git_status'
      end,
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = { 'git_add_all', desc = 'Stage all changes' },
          ['gu'] = { 'git_unstage_file', desc = 'Unstage file' },
          ['ga'] = { 'git_add_file', desc = 'Stage file' },
          ['gr'] = { 'git_revert_file', desc = 'Revert file' },
          ['gc'] = { 'git_commit', desc = 'Commit changes' },
          ['gp'] = { 'git_push', desc = 'Push changes' },
          ['gg'] = { 'git_commit_and_push', desc = 'Commit and push' },
          ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' }, desc = 'Show order options' },
          ['oc'] = { 'order_by_created', nowait = false, desc = 'Order by creation time' },
          ['od'] = { 'order_by_diagnostics', nowait = false, desc = 'Order by diagnostics' },
          ['om'] = { 'order_by_modified', nowait = false, desc = 'Order by modified time' },
          ['on'] = { 'order_by_name', nowait = false, desc = 'Order by name' },
          ['os'] = { 'order_by_size', nowait = false, desc = 'Order by size' },
          ['ot'] = { 'order_by_type', nowait = false, desc = 'Order by type' },
        },
      },
    },
    close_if_last_window = true,
    enable_git_status = true,
    modified = {
      symbol = '[+]',
      highlight = 'NeoTreeModified',
    },
    file_size = {
      enabled = true,
      required_width = 40, -- min width of window required to show this column
    },
    type = {
      enabled = true,
      required_width = 122, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 88, -- min width of window required to show this column
    },
    created = {
      enabled = true,
      required_width = 110, -- min width of window required to show this column
    },
  },
}
