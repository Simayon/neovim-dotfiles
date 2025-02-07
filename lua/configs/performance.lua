-- Performance related settings
local M = {}

function M.setup()
    -- Reduce the time that neovim waits after each keystroke
    vim.opt.updatetime = 250
    vim.opt.timeout = true
    vim.opt.timeoutlen = 300

    -- Disable some built-in plugins we don't use
    local disabled_built_ins = {
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit"
    }

    for _, plugin in pairs(disabled_built_ins) do
        vim.g["loaded_" .. plugin] = 1
    end

    -- More efficient lua module loading
    vim.loader.enable()

    -- Configure LSP to be less aggressive
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            -- Reduce update time for hover
            update_events = {"CursorHold", "CursorHoldI"},
        }
    )

    -- Configure treesitter to be less resource intensive if it's available
    local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if ok then
        treesitter.setup {
            highlight = {
                enable = true,
                -- Disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
        }
    end
end

return M
