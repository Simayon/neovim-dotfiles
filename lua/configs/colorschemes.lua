-- Colorscheme plugins collection
-- Simple format: just add plugin URL and optional config

local themes = {
	-- Format: { "author/plugin", name = "theme_name", opts = {}, setup_name = "module_name" }

	{
		"0xstepit/flow.nvim",
		name = "flow",
		tag = "v2.0.0",
		opts = {
			transparent = false,
			fluo_color = "pink",
			mode = "normal", -- normal, bright, desaturate, dark
		},
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				telescope = true,
			},
		},
	},

	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		opts = {
			style = "night", -- storm, moon, night, day
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
		},
	},

	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			theme = "wave", -- wave, dragon, lotus
		},
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github_dark",
		setup_name = "github-theme",
		opts = {
			options = {
				transparent = false,
				terminal_colors = true,
				dim_inactive = false,
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			},
		},
	},

	{
		"navarasu/onedark.nvim",
		name = "onedark",
		opts = {
			style = "dark", -- dark, darker, cool, deep, warm, warmer
			transparent = false,
			term_colors = true,
			ending_tildes = false,
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
		},
	},

	{
		"philosofonusus/morta.nvim",
		name = "morta",
		opts = {},
	},

	-- Add more themes here - Examples:
	-- { "rose-pine/neovim", name = "rose-pine", opts = { variant = "moon" } },
	-- { "EdenEast/nightfox.nvim", name = "nightfox", opts = { options = { transparent = false } } },
}

-- Auto-configure all themes (no need to edit below this line)
for _, theme in ipairs(themes) do
	theme.lazy = false
	theme.priority = 1000

	-- Auto-generate config function
	theme.config = function()
		local setup_name = theme.setup_name or theme.name
		local ok, module = pcall(require, setup_name)
		if ok then
			module.setup(theme.opts or {})
		end
	end
end

return themes
