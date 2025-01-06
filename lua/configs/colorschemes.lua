return {
	{
		"0xstepit/flow.nvim",
		name = "flow",
		lazy = false,
		priority = 1000,
		tag = "v2.0.0",
		config = function()
			require("flow").setup()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			require("tokyonight").setup()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
		config = function()
			require("kanagawa").setup()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github_dark",
		priority = 1000,
		config = function()
			require("github-theme").setup()
			vim.cmd.colorscheme("github_dark")
		end,
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		priority = 1000,
		config = function()
			require("onedark").setup()
			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"philosofonusus/morta.nvim",
		name = "morta",
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("morta")
		end,
	},
}
