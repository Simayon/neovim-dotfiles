return {
	"lewis6991/gitsigns.nvim",
	opts = {
		-- Git signs configuration for the gutter
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		-- Show line blame inline
		current_line_blame = false,
		-- Delay before showing line blame (ms)
		current_line_blame_opts = {
			delay = 300,
		},
		-- Enable inline diff view
		diff_opts = {
			internal = true,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			-- Helper function to set keymaps for the buffer
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- ============================================================================
			-- Navigation: Jump between git changes
			-- ============================================================================

			-- Jump to next hunk/change
			map("n", "]c", function()
				if vim.wo.diff then
					-- If in diff mode, use vim's built-in ]c
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange" })

			-- Jump to previous hunk/change
			map("n", "[c", function()
				if vim.wo.diff then
					-- If in diff mode, use vim's built-in [c
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Jump to previous git [c]hange" })

			-- Jump to first hunk in buffer
			map("n", "]C", function()
				gitsigns.nav_hunk("first")
			end, { desc = "Jump to first git change" })

			-- Jump to last hunk in buffer
			map("n", "[C", function()
				gitsigns.nav_hunk("last")
			end, { desc = "Jump to last git change" })

			-- ============================================================================
			-- Actions: Stage and reset hunks
			-- ============================================================================

			-- Stage hunk in visual mode (selected lines)
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [s]tage hunk" })

			-- Reset hunk in visual mode (selected lines)
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [r]eset hunk" })

			-- Stage single hunk under cursor
			map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })

			-- Reset single hunk under cursor
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })

			-- Stage all hunks in current buffer
			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })

			-- Reset all hunks in current buffer
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })

			-- ============================================================================
			-- Preview and diff: View changes without leaving the buffer
			-- ============================================================================

			-- Preview hunk changes in floating window
			map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })

			-- Preview hunk changes inline (stays in buffer)
			map("n", "<leader>gh", gitsigns.preview_hunk_inline, { desc = "git preview [h]unk inline" })

			-- Open diff view comparing working tree to index
			map("n", "<leader>gd", gitsigns.diffthis, { desc = "git [d]iff against index" })

			-- Open diff view comparing working tree to last commit
			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, { desc = "git [D]iff against last commit" })

			-- ============================================================================
			-- Blame: See who changed what and when
			-- ============================================================================

			-- Show full commit info for current line
			map("n", "<leader>gb", gitsigns.blame_line, { desc = "git [b]lame line" })

			-- Toggle inline blame for current line
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })

			-- ============================================================================
			-- Text objects: Operate on hunks with vim motions
			-- ============================================================================

			-- Select hunk as a text object (e.g., yih to yank hunk, dih to delete)
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "git select hunk" })

			-- ============================================================================
			-- Toggles: Show/hide various git information
			-- ============================================================================

			-- Toggle word diff highlighting
			map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle git [w]ord diff" })

			-- Toggle line number highlighting for changed lines
			map("n", "<leader>tl", gitsigns.toggle_numhl, { desc = "[T]oggle git [l]ine number highlight" })

			-- Toggle gitsigns entirely
			map("n", "<leader>tg", gitsigns.toggle_signs, { desc = "[T]oggle [g]itsigns" })

			-- ============================================================================
			-- List all hunks: Useful for reviewing all changes
			-- ============================================================================

			-- Send all hunks to quickfix list
			map("n", "<leader>gq", gitsigns.setqflist, { desc = "git hunks to [q]uickfix" })

			-- Send all hunks to location list
			map("n", "<leader>gl", gitsigns.setloclist, { desc = "git hunks to [l]ocation list" })
		end,
	},
}
