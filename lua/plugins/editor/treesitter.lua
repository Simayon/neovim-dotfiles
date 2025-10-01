return {
	{
		-- Treesitter: Advanced syntax highlighting and code understanding
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Required fields for treesitter configuration
				modules = {},
				sync_install = true,
				ignore_install = {},

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- List of language parsers to install
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"go",
					"lua",
					"python",
					"rust",
					"vim",
					"vimdoc",
				},

				-- Syntax highlighting configuration
				highlight = {
					enable = true,
					-- Disable vim regex highlighting for better performance
					additional_vim_regex_highlighting = false,
				},

				-- Incremental selection: Expand selection based on syntax tree
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>", -- Start selection
						node_incremental = "<C-space>", -- Expand selection to next node
						scope_incremental = false, -- Disabled
						node_decremental = "<bs>", -- Shrink selection (backspace)
					},
				},

				-- Text objects: Operate on code structures (functions, classes, etc.)
				textobjects = {
					-- Select text objects
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to text object

						keymaps = {
							-- Function text objects
							["af"] = "@function.outer", -- Select entire function including signature
							["if"] = "@function.inner", -- Select function body only

							-- Class text objects
							["ac"] = "@class.outer", -- Select entire class including declaration
							["ic"] = "@class.inner", -- Select class body only

							-- Parameter/argument text objects
							["aa"] = "@parameter.outer", -- Select parameter including commas
							["ia"] = "@parameter.inner", -- Select parameter value only
						},
					},

					-- Swap text objects (useful for reordering parameters, functions)
					swap = {
						enable = true,

						-- Swap with next
						swap_next = {
							["]p"] = "@parameter.inner", -- Swap current parameter with next
							["]f"] = "@function.outer", -- Swap current function with next
						},

						-- Swap with previous
						swap_previous = {
							["[p"] = "@parameter.inner", -- Swap current parameter with previous
							["[f"] = "@function.outer", -- Swap current function with previous
						},
					},

					-- Navigate between functions and classes
					move = {
						enable = true,
						set_jumps = true, -- Add movements to jumplist (<C-o> to go back)

						-- Go to next start
						goto_next_start = {
							["]m"] = "@function.outer", -- Next function start
							["]]"] = "@class.outer", -- Next class start
						},

						-- Go to next end
						goto_next_end = {
							["]M"] = "@function.outer", -- Next function end
							["]["] = "@class.outer", -- Next class end
						},

						-- Go to previous start
						goto_previous_start = {
							["[m"] = "@function.outer", -- Previous function start
							["[["] = "@class.outer", -- Previous class start
						},

						-- Go to previous end
						goto_previous_end = {
							["[M"] = "@function.outer", -- Previous function end
							["[]"] = "@class.outer", -- Previous class end
						},
					},
				},
			})

			-- Make text object movements repeatable with ; (forward) and , (backward)
			-- This allows you to press ]m once, then ; ; ; to keep moving forward
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
		end,
	},
}
