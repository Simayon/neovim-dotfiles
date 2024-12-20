return {
	"kevinhwang91/nvim-bqf",
	ft = "qf", -- Only load when quickfix window is opened
	opts = {
		auto_enable = true, -- Automatically enable for quickfix windows
		preview = {
			win_height = 12, -- Height of preview window
			win_vheight = 12, -- Height for vertical preview
			delay_syntax = 80, -- Delay before syntax highlighting
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }, -- Pretty borders
		},
		func_map = {
			vsplit = "", -- Key for vertical split
			ptogglemode = "z,", -- Toggle preview mode
			stoggleup = "", -- Toggle sign up
		},
		filter = {
			fzf = { -- Integration with fzf
				action_for = { ["ctrl-s"] = "split" }, -- Ctrl-s to open in split
				extra_opts = {
					"--bind",
					"ctrl-o:toggle-all", -- Ctrl-o to toggle all items
					"--prompt",
					"> ", -- Custom prompt
				},
			},
		},
	},
}
