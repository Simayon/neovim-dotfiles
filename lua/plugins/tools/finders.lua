return {
	{
		"ibhagwan/fzf-lua",
		event = { "VimEnter" },
		dependencies = { "nvim-tree/nvim-web-devicons", "which-key.nvim" },
		config = function()
			local fzf = require("fzf-lua")
			-- Configure default options
			fzf.setup({
				winopts = {
					-- Make the window larger and centered
					height = 0.90,
					width = 0.90,
					row = 0.45,
					col = 0.5,
					-- Preview configuration
					preview = {
						default = "bat",
						vertical = "right:60%", -- Larger preview window
						horizontal = "right:65%", -- For horizontal preview
						layout = "horizontal", -- Try horizontal layout
						delay = 50,
						scrollbar = "float",
						title = true,
						title_pos = "left",
						border = "rounded",
						scrollchar = "▊",
						scrolloff = 5,
						winopts = {
							cursorline = true,
							cursorlineopt = "both",
							number = true,
							relativenumber = true,
							wrap = false,
							list = false,
							foldcolumn = "0",
							signcolumn = "no",
						},
					},
					-- Stylize the window
					border = "rounded",
					hls = {
						normal = "Normal",
						border = "FloatBorder",
						preview_normal = "Normal",
						preview_border = "FloatBorder",
						cursorline = "CursorLine",
						cursorlinenr = "CursorLineNr",
						title = "FloatTitle",
						preview_title = "FloatTitle",
					},
					-- Set minimum window sizes
					preview_min_width = 40,
					min_width = 40,
					min_height = 10,
				},
				keymap = {
					builtin = {
						["<C-/>"] = "toggle-preview",
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
				},
				fzf_opts = {
					["--bind"] = {
						"ctrl-n:next-history",
						"ctrl-p:previous-history",
						"ctrl-j:down",
						"ctrl-k:up",
						"change:first", -- Go to top when search changes
					},
					["--info"] = "default",
					["--layout"] = "reverse-list",
					["--border"] = "none",
					["--margin"] = "0",
					["--padding"] = "0",
					["--pointer"] = "▶",
					["--marker"] = "✓",
					["--header-first"] = false,
					["--color"] = "bg+:-1,fg+:blue,pointer:magenta,marker:magenta,prompt:gray,header:gray",
				},
				-- Add icons
				previewers = {
					bat = {
						theme = "Nord",
						config = "--style=numbers,changes --wrap never --color always",
					},
				},
				files = {
					prompt = "  ",
					git_icons = true,
					file_icons = true,
					color_icons = true,
					case_mode = "smart",
					cmd = "rg --files --hidden --follow --glob '!.git' --glob '!node_modules'",
				},
				buffers = {
					prompt = "󰈙  ",
					git_icons = true,
					file_icons = true,
					color_icons = true,
					sort_lastused = true,
				},
				grep = {
					prompt = "  ",
					git_icons = true,
					file_icons = true,
					color_icons = true,
					multiprocess = true,
					rg_opts = "--hidden --column --line-number --no-heading "
						.. "--color=always --smart-case -g '!{.git,node_modules}/*'",
				},
				git = {
					status = {
						prompt = "󰊢  ",
						cmd = "git status -s",
						preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
						actions = {
							["ctrl-x"] = { fn = fzf.actions.git_reset, reload = true },
						},
					},
					commits = {
						prompt = "  ",
						cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s'",
						preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
					},
				},
			})

			-- Register which-key groups
			local wk = require("which-key")
			wk.add({
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>l", group = "[L]SP" },
			})

			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
			end

			-- Basic file operations
			map("<leader>sh", fzf.help_tags, "[S]earch [H]elp")
			map("<leader>sk", fzf.keymaps, "[S]earch [K]eymaps")
			map("<leader>sf", fzf.files, "[S]earch [F]iles")
			map("<leader>ss", fzf.builtin, "[S]earch [S]elect FZF")
			map("<leader>sw", fzf.grep_cword, "[S]earch current [W]ord")
			map("<leader>sg", fzf.live_grep, "[S]earch by [G]rep")
			map("<leader>sd", fzf.diagnostics_document, "[S]earch [D]iagnostics")
			map("<leader>sr", fzf.resume, "[S]earch [R]esume")
			map("<leader>s.", fzf.oldfiles, "[S]earch Recent Files")
			map("<leader><leader>", fzf.buffers, "[B]uffers")

			-- Additional search features
			map("<leader>/", function()
				fzf.grep_curbuf({
					prompt = "Buffer>",
					winopts = {
						preview = { hidden = false },
					},
				})
			end, "[/] Search in Buffer")

			map("<leader>s/", function()
				fzf.live_grep({
					prompt = "Grep Open Files>",
					grep_open_files = true,
				})
			end, "[S]earch [/] in Open Files")

			-- Git operations
			map("<leader>gc", fzf.git_commits, "[G]it [C]ommits")
			map("<leader>gs", fzf.git_status, "[G]it [S]tatus")
		end,
	},
}
