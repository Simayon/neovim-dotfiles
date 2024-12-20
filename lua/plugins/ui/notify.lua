return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        local notify = require("notify")

        -- Messages to filter out
        local filtered_messages = {
            -- Startup and initialization
            "^Error executing lua callback:",
            "^Error detected while processing",
            "^stack traceback:",
            -- Specific errors to filter
            "ENAMETOOLONG:",
            "attempt to concatenate",
            -- LSP and diagnostic messages
            "^LSP.*language server",
            "^LSP.*Processing",
            "^LSP.*Connecting",
    --        "^LSP.*initialized",
            -- Git messages
            "^Git.*Pushing",
            "^Git.*Pulling",
            -- File messages
            "^written$",
            "^[0-9]+ lines yanked$",
            "^[0-9]+ more lines$",
            "^[0-9]+ fewer lines$",
            "^[0-9]+ lines >ed$",
            "^[0-9]+ lines <ed$",
            -- Search messages
            "^[0-9]+ matches on [0-9]+ lines$",
            "^search hit .*, continuing at .*$",
            "^Pattern not found.*$",
            -- Treesitter messages
            "^Tree-sitter .* parser installed$",
        }

        -- Suppress startup messages and handle notifications
        vim.notify = function(msg, level, opts)
            -- Skip if message is nil or empty
            if not msg or msg == "" then
                return
            end

            -- Skip during startup
            if vim.v.vim_did_enter ~= 1 then
                return
            end

            -- Skip message-type notifications
            if level == vim.log.levels.INFO then
                return
            end

            -- Check if message should be filtered
            for _, pattern in ipairs(filtered_messages) do
                if msg:match(pattern) then
                    return
                end
            end

            -- Forward to notify if message isn't filtered
            notify(msg, level, opts)
        end

        -- More minimal and less distracting notification setup
        notify.setup({
            -- Simple fade animation
            stages = "static",
            
            -- Shorter timeout
            timeout = 2000,
            
            -- Darker, less noticeable background
            background_colour = "#000000",
            
            -- Minimal dimensions
            minimum_width = 40,
            max_width = 60,
            max_height = 5,
            
            -- Simple icons
            icons = {
                ERROR = "✘",
                WARN = "⚠",
                INFO = "ℹ",
                DEBUG = "⚙",
                TRACE = "↪",
            },

            -- Minimal render style
            render = "minimal",
            
            -- Faster animations
            fps = 30,
            
            -- Position at the bottom to be less distracting
            top_down = false,
            
            -- Simpler time format
            time_formats = {
                notification = "%H:%M",
                notification_history = "%H:%M",
            },

            -- Only show important notifications
            level = vim.log.levels.WARN,
        })

        -- Minimal highlight groups with muted colors
        vim.cmd([[
            highlight NotifyERRORBorder guifg=#4a1f1f
            highlight NotifyWARNBorder guifg=#4a3f1f
            highlight NotifyINFOBorder guifg=#1f4a2f
            highlight NotifyDEBUGBorder guifg=#3f3f3f
            highlight NotifyTRACEBorder guifg=#2f1f4a
            highlight NotifyERRORIcon guifg=#db4b4b
            highlight NotifyWARNIcon guifg=#e0af68
            highlight NotifyINFOIcon guifg=#4aa653
            highlight NotifyDEBUGIcon guifg=#767676
            highlight NotifyTRACEIcon guifg=#9854cb
            highlight NotifyERRORTitle guifg=#db4b4b
            highlight NotifyWARNTitle guifg=#e0af68
            highlight NotifyINFOTitle guifg=#4aa653
            highlight NotifyDEBUGTitle guifg=#767676
            highlight NotifyTRACETitle guifg=#9854cb
            highlight NotifyBackground guibg=#000000
        ]])

        -- Helper function to show notification history
        vim.api.nvim_create_user_command("NotifyHistory", function()
            require("notify").history()
        end, {})

        -- Keymaps for notification history
        vim.keymap.set("n", "<leader>nh", "<cmd>NotifyHistory<CR>", { desc = "Show [N]otification [H]istory" })
        vim.keymap.set("n", "<leader>nd", function()
            require("notify").dismiss({ silent = true, pending = true })
        end, { desc = "[N]otification [D]ismiss all" })
    end
}
