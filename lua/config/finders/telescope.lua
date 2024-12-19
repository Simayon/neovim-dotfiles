return {
	"nvim-telescope/telescope.nvim",
	event = { "VimEnter", "BufReadPre" },
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		-- Register which-key groups
		local wk = require("which-key")
		wk.add("<leader>s", { name = "[S]earch" })
		wk.add("<leader>g", { name = "[G]it" })
		wk.add("<leader>l", { name = "[L]SP" })

		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
		end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		-- Basic file operations
		map("<leader>sf", builtin.find_files, "[S]earch [F]iles")
		map("<leader>s.", builtin.oldfiles, "[S]earch Recent Files")
		map("<leader><leader>", builtin.buffers, "[ ] Buffers")
		
		-- Search operations
		map("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
		map("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
		map("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
		map("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
		map("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
		map("<leader>sr", builtin.resume, "[S]earch [R]esume")
		map("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
		
		-- Additional search features
		map("<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, "[/] Search in Buffer")

		map("<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, "[S]earch [/] in Open Files")
		
		-- Git operations
		map("<leader>gc", builtin.git_commits, "[G]it [C]ommits")
		map("<leader>gb", builtin.git_branches, "[G]it [B]ranches")
		map("<leader>gs", builtin.git_status, "[G]it [S]tatus")
		map("<leader>gf", builtin.git_files, "[G]it [F]iles")

		-- LSP operations
		map("<leader>lr", builtin.lsp_references, "[L]SP [R]eferences")
		map("<leader>ld", builtin.lsp_definitions, "[L]SP [D]efinitions")
		map("<leader>ls", builtin.lsp_document_symbols, "[L]SP [S]ymbols")
		map("<leader>li", builtin.lsp_implementations, "[L]SP [I]mplementations")
		map("<leader>lt", builtin.lsp_type_definitions, "[L]SP [T]ype Definitions")
	end,
}
