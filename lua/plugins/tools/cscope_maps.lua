
return {
    "dhananjaylatkar/cscope_maps.nvim",
    event = "VeryLazy", -- Load plugin lazily; adjust if you want it earlier
    config = function()
        require("cscope_maps").setup({})
    end,
}
