return {
	"Saghen/blink.cmp",
	version = "v0.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			config = function()
				require("luasnip").setup({})
			end,
		},
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function(_, opts)
		require("blink.cmp").setup(opts)
	end,
	opts = {
		keymap = {
			preset = "super-tab",
			-- Additional custom keymaps
			["<C-d>"] = { "scroll_documentation_down" },
			["<C-u>"] = { "scroll_documentation_up" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
			["<C-space>"] = { "show", "show_documentation" },
			["<C-e>"] = { "hide", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				enabled = true,
				min_width = 25,
				max_height = 15,
				border = "rounded",
				winblend = 0,
				scrolloff = 3,
				scrollbar = true,
				direction_priority = { "s", "n" },
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
					},
					padding = { 1, 1 },
					gap = 1,
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				update_delay_ms = 50,
				treesitter_highlighting = true,
				window = {
					min_width = 20,
					max_width = 80,
					max_height = 25,
					border = "rounded",
					winblend = 0,
					scrollbar = true,
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		snippets = {
			expand = function(snippet)
				local ls = require("luasnip")
				ls.lsp_expand(snippet)
			end,
			active = function(filter)
				local ls = require("luasnip")
				if filter and filter.direction then
					return ls.jumpable(filter.direction)
				end
				return ls.in_snippet()
			end,
			jump = function(direction)
				local ls = require("luasnip")
				ls.jump(direction)
			end,
		},
		fuzzy = {
			use_typo_resistance = true,
			use_frecency = true,
			use_proximity = true,
			max_items = 200,
			sorts = { "score", "sort_text" },
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				max_width = 100,
				max_height = 15,
				winblend = 0,
				scrollbar = true,
				treesitter_highlighting = true,
			},
		},
	},
}
