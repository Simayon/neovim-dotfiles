return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts
					or {
						signs = {
							add = { text = "+" },
							change = { text = "~" },
							delete = { text = "_" },
							topdelete = { text = "‾" },
							changedelete = { text = "~" },
						},
					}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Jump to previous git [c]hange" })

			-- Actions
			-- visual mode
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git stage hunk" })
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git reset hunk" })
			-- normal mode
			map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
			map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
			map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "git [b]lame line" })
			map("n", "<leader>gd", gitsigns.diffthis, { desc = "git [d]iff this" })
			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, { desc = "git [D]iff this ~" })
			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
			map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
		end,
	},
}
