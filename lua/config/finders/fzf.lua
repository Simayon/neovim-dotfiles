return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		-- Register which-key groups
		local wk = require("which-key")
		wk.add("<leader>s", { name = "[S]earch" })
		wk.add("<leader>g", { name = "[G]it" })
		wk.add("<leader>l", { name = "[L]SP" })

		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
		end

		-- Basic file operations
		map("<leader>sf", fzf.files, "[S]earch [F]iles")
		map("<leader>s.", fzf.oldfiles, "[S]earch Recent Files")
		map("<leader><leader>", fzf.buffers, "[ ] Buffers")
		
		-- Search operations
		map("<leader>sg", fzf.live_grep, "[S]earch by [G]rep")
		map("<leader>sw", fzf.grep_cword, "[S]earch current [W]ord")
		map("<leader>sh", fzf.help_tags, "[S]earch [H]elp")
		map("<leader>sd", fzf.diagnostics_document, "[S]earch [D]iagnostics")
		map("<leader>sk", fzf.keymaps, "[S]earch [K]eymaps")
		map("<leader>sr", fzf.resume, "[S]earch [R]esume")
		map("<leader>ss", fzf.builtin, "[S]earch [S]elect FZF")
		
		-- Additional search features
		map("<leader>/", function()
			fzf.grep_curbuf({
				prompt = "Buffer>",
				winopts = {
					height = 0.6,
					width = 0.6,
					preview = { hidden = "hidden" },
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
		map("<leader>gb", fzf.git_branches, "[G]it [B]ranches")
		map("<leader>gs", fzf.git_status, "[G]it [S]tatus")
		map("<leader>gf", fzf.git_files, "[G]it [F]iles")

		-- LSP operations
		map("<leader>lr", fzf.lsp_references, "[L]SP [R]eferences")
		map("<leader>ld", fzf.lsp_definitions, "[L]SP [D]efinitions")
		map("<leader>ls", fzf.lsp_document_symbols, "[L]SP [S]ymbols")
		map("<leader>li", fzf.lsp_implementations, "[L]SP [I]mplementations")
		map("<leader>lt", fzf.lsp_typedefs, "[L]SP [T]ype Definitions")
	end,
}
