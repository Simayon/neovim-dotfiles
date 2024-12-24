return {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Open Cheatsheet" },
    },
    config = function()
        require("cheatsheet").setup({
            -- Use bundled cheatsheets
            bundled_cheatsheets = true,
            -- Use bundled plugin cheatsheets
            bundled_plugin_cheatsheets = true,
            -- Show only installed plugins' cheatsheets
            include_only_installed_plugins = true,
        })

        -- Add which-key group
        require("which-key").register({
            ["<leader>?"] = { name = "Cheatsheet", _ = "which_key_ignore" },
        })
    end,
}
