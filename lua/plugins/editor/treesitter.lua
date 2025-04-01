return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                -- List of parsers to install
                ensure_installed = {
                    "bash", "c", "cpp", "go", "lua", "python", "rust",
                    "vim", "vimdoc",
                },
                
                -- Enable syntax highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                -- Enable incremental selection
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },

                -- Enable text objects and movement
                textobjects = {
                    -- Define text object selection
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",  -- Select outer part of a function
                            ["if"] = "@function.inner",  -- Select inner part of a function
                            ["ac"] = "@class.outer",     -- Select outer part of a class
                            ["ic"] = "@class.inner",     -- Select inner part of a class
                            ["aa"] = "@parameter.outer", -- Select outer part of a parameter
                            ["ia"] = "@parameter.inner", -- Select inner part of a parameter
                        },
                    },
                    -- Swap functionality
                    swap = {
                        enable = true,
                        swap_next = {
                            ["]p"] = "@parameter.inner", -- Swap parameter with next
                            ["]f"] = "@function.outer",  -- Swap function with next
                        },
                        swap_previous = {
                            ["[p"] = "@parameter.inner", -- Swap parameter with previous
                            ["[f"] = "@function.outer",  -- Swap function with previous
                        },
                    },
                    -- Movement between functions/classes
                    move = {
                        enable = true,
                        set_jumps = true, -- Track in jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            })

            -- Make the movements repeatable with ; and ,
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        end,
    },
}
