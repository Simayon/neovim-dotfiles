return {
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        tag = "v2.0.0",
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "ziontee113/color-picker.nvim",
        cmd = { "PickColor", "PickColorInsert" },
        config = function()
            require("color-picker").setup()
            -- Keymaps
            vim.keymap.set("n", "<leader>cp", "<cmd>PickColor<cr>", { desc = "Color Picker" })
            vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", { desc = "Color Picker Insert" })
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
    },
    {
        "projekt0n/github-nvim-theme",
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        priority = 1000,
    },
    {
        "zaldih/themery.nvim",
        lazy = false,
        keys = {
            { "<leader>tc", "<cmd>Themery<cr>", desc = "Toggle Colorscheme" },
        },
        config = function()
            require("themery").setup({
                themes = {
                    {
                        name = "Flow",
                        colorscheme = "flow",
                        before = [[
                            vim.opt.background = "dark"
                        ]],
                    },
                    {
                        name = "Catppuccin",
                        colorscheme = "catppuccin",
                    },
                    {
                        name = "Tokyo Night",
                        colorscheme = "tokyonight",
                    },
                    {
                        name = "Kanagawa",
                        colorscheme = "kanagawa",
                    },
                    {
                        name = "GitHub Dark",
                        colorscheme = "github_dark",
                    },
                    {
                        name = "OneDark",
                        colorscheme = "onedark",
                    },
                },
                livePreview = true,
                globalBefore = [[
                    -- Reset any existing theme settings
                    vim.cmd("hi clear")
                ]],
                globalAfter = [[
                    -- Refresh UI components after theme change
                    if package.loaded["feline"] then
                        require("feline").reset_highlights()
                    end
                    if package.loaded["bufferline"] then
                        require("bufferline").setup{}
                    end
                ]],
            })
        end,
    },
}
