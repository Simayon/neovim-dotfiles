return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			-- Core settings
			save_path = vim.fn.stdpath("data") .. "/dooing_todos.json",

			-- Window settings
			window = {
				width = 55, -- Width of the floating window
				height = 20, -- Height of the floating window
				border = "rounded", -- Border style
				padding = {
					top = 1,
					bottom = 1,
					left = 2,
					right = 2,
				},
			},

			-- To-do formatting
			formatting = {
				pending = {
					icon = "○",
					format = { "icon", "notes_icon", "text", "due_date", "ect" },
				},
				in_progress = {
					icon = "◐",
					format = { "icon", "text", "due_date", "ect" },
				},
				done = {
					icon = "✓",
					format = { "icon", "notes_icon", "text", "due_date", "ect" },
				},
			},

			quick_keys = true, -- Quick keys window

			notes = {
				icon = "📓",
			},

			scratchpad = {
				syntax_highlight = "markdown",
			},

			-- Keymaps
			keymaps = {
				toggle_window = "<leader>td",
				new_todo = "i",
				toggle_todo = "x",
				delete_todo = "d",
				delete_completed = "D",
				close_window = "q",
				undo_delete = "u",
				add_due_date = "H",
				remove_due_date = "r",
				toggle_help = "?",
				toggle_tags = "t",
				toggle_priority = "<Space>",
				clear_filter = "c",
				edit_todo = "e",
				edit_tag = "e",
				delete_tag = "d",
				search_todos = "/",
				add_time_estimation = "T",
				remove_time_estimation = "R",
				import_todos = "I",
				export_todos = "E",
				remove_duplicates = "<leader>D",
				open_todo_scratchpad = "<leader>p",
			},

			calendar = {
				language = "en",
				icon = "",
				keymaps = {
					previous_day = "h",
					next_day = "l",
					previous_week = "k",
					next_week = "j",
					previous_month = "H",
					next_month = "L",
					select_day = "<CR>",
					close_calendar = "q",
				},
			},

			-- Priority settings
			priorities = {
				{
					name = "important",
					weight = 4,
				},
				{
					name = "urgent",
					weight = 2,
				},
			},
			priority_groups = {
				high = {
					members = { "important", "urgent" },
					color = nil,
					hl_group = "DiagnosticError",
				},
				medium = {
					members = { "important" },
					color = nil,
					hl_group = "DiagnosticWarn",
				},
				low = {
					members = { "urgent" },
					color = nil,
					hl_group = "DiagnosticInfo",
				},
			},
			hour_score_value = 1 / 8,
		})
	end,
}
