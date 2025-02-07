return {
	"Saghen/blink.cmp",
	event = "InsertEnter",
	build = "cargo build --release",
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"jc-doyle/cmp-pandoc-references",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				{
					"iurimateus/luasnip-latex-snippets.nvim",
					ft = { "tex", "bib" },
				},
			},
			config = function()
				local ls = require("luasnip")
				local ls_types = require("luasnip.util.types")

				ls.setup({
					keep_roots = true,
					link_roots = true,
					exit_roots = false,
					link_children = true,
					region_check_events = "CursorMoved,CursorMovedI",
					delete_check_events = "TextChanged,TextChangedI",
					enable_autosnippets = true,
					store_selection_keys = "<Tab>",
					ext_opts = {
						[ls_types.insertNode] = {
							unvisited = {
								virt_text_pos = "inline",
							},
						},
						[ls_types.exitNode] = {
							unvisited = {
								virt_text_pos = "inline",
							},
						},
					},
				})

				-- Unlink current snippet on leaving insert/selection mode
				-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
				vim.api.nvim_create_autocmd("ModeChanged", {
					desc = "Unlink current snippet on leaving insert/selection mode.",
					group = vim.api.nvim_create_augroup("LuaSnipModeChanged", {}),
					callback = function(info)
						local mode = vim.v.event.new_mode
						local omode = vim.v.event.old_mode
						if
							(omode == "s" and mode == "n" or omode == "i")
							and ls.session.current_nodes[info.buf]
							and not ls.session.jump_active
						then
							ls.unlink_current()
						end
					end,
				})

				---Load snippets for a given filetype
				---@param ft string
				---@return nil
				local function load_snippets(ft)
					local ok, snip_groups = pcall(require, "snippets." .. ft)
					if ok and type(snip_groups) == "table" then
						for _, snip_group in pairs(snip_groups) do
							ls.add_snippets(ft, snip_group.snip or snip_group, snip_group.opts or {})
						end
					end
				end

				-- Lazy-load snippets based on filetype
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					load_snippets(vim.bo[buf].ft)
				end
				vim.api.nvim_create_autocmd("FileType", {
					group = vim.api.nvim_create_augroup("LuaSnipLazyLoadSnippets", {}),
					desc = "Lazy load snippets for different filetypes.",
					callback = function(info)
						load_snippets(vim.bo[info.buf].ft)
					end,
				})
			end,
		},
		{ "saghen/blink.compat", version = "*", opts = { impersonate_nvim_cmp = true } },
		"mikavilpas/blink-ripgrep.nvim",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "super-tab" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = { enabled = false },
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1, "kind" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
							end,
						},
						kind = {
							text = function(ctx)
								return "(" .. ctx.kind .. ")"
							end,
							highlight = function(ctx)
								return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
									or "BlinkCmpCustomType"
							end,
						},
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "luasnip", "ripgrep", "supermaven" },
			per_filetype = {
				markdown = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"luasnip",
					"ripgrep",
					"supermaven",
					"pandoc_references",
				},
				tex = { "lsp", "path", "snippets", "buffer", "luasnip", "ripgrep", "supermaven", "pandoc_references" },
			},
			providers = {
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					score_offset = -4,
					opts = {
						prefix_min_len = 3,
						context_size = 5,
						max_filesize = "1G",
					},
				},
				pandoc_references = {
					name = "pandoc_references",
					module = "blink.compat.source",
					score_offset = -1,
				},
				supermaven = {
					name = "supermaven",
					module = "blink.compat.source",
					score_offset = 100,
					async = true,
				},
			},
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
