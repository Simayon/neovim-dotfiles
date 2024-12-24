return {
	"saghen/blink.cmp",
	enabled = true,
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				require("luasnip").setup({})
			end,
		},
		{
			"giuxtaposition/blink-cmp-copilot",
		},
	},
	build = "cargo build --release",
	opts = {
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot", "luasnip" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					score_offset = 1000,
				},
				luasnip = {
					name = "luasnip",
					enabled = true,
					module = "blink.cmp.sources.luasnip",
					score_offset = 950,
				},
				snippets = {
					name = "snippets",
					enabled = true,
					module = "blink.cmp.sources.snippets",
					score_offset = 900,
				},
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot = "",
				Text = '󰉿',
				Method = '󰊕',
				Function = '󰊕',
				Constructor = '󰒓',
				Field = '󰜢',
				Variable = '󰆦',
				Property = '󰖷',
				Class = '󱡠',
				Interface = '󱡠',
				Struct = '󱡠',
				Module = '󰅩',
				Unit = '󰪚',
				Value = '󰦨',
				Enum = '󰦨',
				EnumMember = '󰦨',
				Keyword = '󰻾',
				Constant = '󰏿',
				Snippet = '󱄽',
				Color = '󰏘',
				File = '󰈔',
				Reference = '󰬲',
				Folder = '󰉋',
				Event = '󱐋',
				Operator = '󰪚',
				TypeParameter = '󰬛',
			},
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
		snippets = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
			active = function()
				local luasnip = require("luasnip")
				return luasnip.session
					and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
					and not luasnip.session.jump_active
			end,
			jump = function(direction)
				if require("luasnip").jumpable(direction) then
					require("luasnip").jump(direction)
				end
			end,
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
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-u>"] = { "scroll_documentation_up" },
			["<C-d>"] = { "scroll_documentation_down" },
			["<C-Space>"] = { "show", "show_documentation" },
			["<C-e>"] = { "hide" },
		},
	},
}
