-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local git_status_footer = function(state)
	local git_status = state.git_status_lookup
	if not git_status then
		return {}
	end

	local added, modified, deleted, untracked = 0, 0, 0, 0
	for _, status in pairs(git_status) do
		if status == "A" then
			added = added + 1
		elseif status == "M" then
			modified = modified + 1
		elseif status == "D" then
			deleted = deleted + 1
		elseif status == "?" then
			untracked = untracked + 1
		end
	end

	return {
		{
			text = string.format("  %d  %d  %d  %d", added, modified, deleted, untracked),
			highlight = "NeoTreeGitStatusFooter",
		},
	}
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal" },
	},
	opts = {
		filesystem = {
			bind_to_cwd = true,
			filtered_items = {
				visible = false, -- Show hidden files but dim them
				hide_dotfiles = true, -- Set to true if you want to hide dotfiles
				hide_gitignored = true, -- This is crucial: it hides files listed in .gitignore
			},
			nesting_rules = {
				["package.json"] = {
					pattern = "^package%.json$", -- <-- Lua pattern
					files = { "package-lock.json", "yarn*" }, -- <-- glob pattern
				},
				["go"] = {
					pattern = "(.*)%.go$",
					files = { "%1_test.go" },
				},
				["js-extended"] = {
					pattern = "(.+)%.js$",
					files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
				},
				["docker"] = {
					pattern = "^dockerfile$",
					ignore_case = true,
					files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
				},
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["\\"] = "close_window",
					["<BS>"] = "navigate_up", -- Use backspace to go up a directory
					["H"] = "toggle_hidden", -- Toggle hidden files
					["<2-LeftMouse>"] = "open",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["i"] = "show_file_details",
				},
			},
		},
		buffers = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				update_cwd = true,
			},
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = { "git_add_all", desc = "Stage all changes" },
					["gu"] = { "git_unstage_file", desc = "Unstage file" },
					["ga"] = { "git_add_file", desc = "Stage file" },
					["gr"] = { "git_revert_file", desc = "Revert file" },
					["gc"] = { "git_commit", desc = "Commit changes" },
					["gp"] = { "git_push", desc = "Push changes" },
					["gg"] = { "git_commit_and_push", desc = "Commit and push" },
					["o"] = {
						"show_help",
						nowait = false,
						config = { title = "Order by", prefix_key = "o" },
						desc = "Show order options",
					},
					["oc"] = { "order_by_created", nowait = false, desc = "Order by creation time" },
					["od"] = { "order_by_diagnostics", nowait = false, desc = "Order by diagnostics" },
					["om"] = { "order_by_modified", nowait = false, desc = "Order by modified time" },
					["on"] = { "order_by_name", nowait = false, desc = "Order by name" },
					["os"] = { "order_by_size", nowait = false, desc = "Order by size" },
					["ot"] = { "order_by_type", nowait = false, desc = "Order by type" },
				},
			},
		},
		close_if_last_window = true,
		enable_git_status = true,
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		file_size = {
			enabled = true,
			required_width = 40, -- min width of window required to show this column
		},
		type = {
			enabled = true,
			required_width = 122, -- min width of window required to show this column
		},
		last_modified = {
			enabled = true,
			required_width = 88, -- min width of window required to show this column
		},
		created = {
			enabled = true,
			required_width = 110, -- min width of window required to show this column
		},
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function(args)
					-- implement a logic on event occurrence
				end,
			},
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
				width = "100%",
				right_padding = 1,
			},
			name = {
				use_git_status_colors = true,
				zindex = 10,
			},
			diagnostics = {
				zindex = 20,
				align = "right",
			},
			git_status = {
				zindex = 20,
				align = "right",
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "NeotreeInit",
			callback = function(args)
				local state = require("neo-tree.sources.manager").get_state("filesystem")
				state.components.footer = git_status_footer
			end,
		})
	end,
	config = function(_, opts)
		require("neo-tree").setup(opts)
		-- Add highlight group for the footer
		vim.api.nvim_set_hl(0, "NeoTreeGitStatusFooter", { fg = "#89b4fa", bold = true })
	end,
}
