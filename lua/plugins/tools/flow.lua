return {
    "arjunmahishi/flow.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("flow").setup({
            output = {
                buffer = true,
                size = "auto",
                focused = true,
                modifiable = false,
            },
        })

        -- Set up keymaps
        vim.keymap.set("v", "<leader>r", ":FlowRunSelected<CR>", { silent = true, desc = "Run selected code" })
        vim.keymap.set("n", "<leader>rr", ":FlowRunFile<CR>", { silent = true, desc = "Run current file" })
        vim.keymap.set("n", "<leader>rt", ":FlowLauncher<CR>", { silent = true, desc = "Open Flow launcher" })
        vim.keymap.set("n", "<leader>rp", ":FlowRunLastCmd<CR>", { silent = true, desc = "Run last Flow command" })
        vim.keymap.set("n", "<leader>ro", ":FlowLastOutput<CR>", { silent = true, desc = "Show last Flow output" })
    end,
}
