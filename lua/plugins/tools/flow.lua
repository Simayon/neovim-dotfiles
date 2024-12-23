return {
    "arjunmahishi/flow.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>r", mode = { "n" }, desc = "+run" },
        { "<leader>r", mode = { "v" }, ":FlowRunSelected<CR>", desc = "Run Selected" },
        { "<leader>rf", ":FlowRunFile<CR>", desc = "Run File" },
        { "<leader>rl", ":FlowLauncher<CR>", desc = "Launcher" },
        { "<leader>rp", ":FlowRunLastCmd<CR>", desc = "Previous" },
        { "<leader>ro", ":FlowLastOutput<CR>", desc = "Output" },
    },
    config = function()
        require("flow").setup({
            output = {
                buffer = true,
                size = "auto",
                focused = true,
                modifiable = false,
            },
        })
    end,
}
