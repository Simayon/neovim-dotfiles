return {
	"m4xshen/hardtime.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		max_time = 1000, -- Reduced from 1000ms to make it more noticeable
		max_count = 3, -- Reduced from 3 to make it more strict
		disable_mouse = true,
		hint = true,
		notification = true,
		allow_different_key = true,
		enabled = true,
		restriction_mode = "block", -- Block repeated keys instead of just hinting
		disabled_keys = {
			["<Up>"] = { "" }, -- Disable in all modes
			["<Down>"] = { "" }, -- Disable in all modes
			["<Left>"] = { "" }, -- Disable in all modes
			["<Right>"] = { "" }, -- Disable in all modes
		},
		disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "TelescopePrompt", "notify", "noice" },
		hints = {
			["k%^"] = {
				message = function()
					return "Use - instead of k^"
				end,
				length = 2,
			},
			["d[tTfF].i"] = {
				message = function(keys)
					return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
				end,
				length = 4,
			},
		},
		callback = function(message)
			vim.notify(message, vim.log.levels.WARN, { -- Changed to WARN for more visibility
				title = "Hardtime",
				icon = "🚫", -- Changed to a more noticeable icon
				timeout = 3000, -- Increased timeout
				render = "default", -- Changed to default for more visible notifications
			})
		end,
		force_exit_insert_mode = true, -- Added to enforce good habits
		max_insert_idle_ms = 3000, -- Reduced from 5000ms
	},
	config = function(_, opts)
		require("hardtime").setup(opts)

		-- Enable hardtime on startup
		vim.cmd("Hardtime enable")

		-- Add a notification to confirm it's enabled
		vim.notify("Hardtime is enabled!", vim.log.levels.INFO, {
			title = "Hardtime",
			icon = "🔒",
			timeout = 3000,
		})
	end,
	keys = {
		{ "<leader>th", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
		{ "<leader>hr", "<cmd>Hardtime report<cr>", desc = "Hardtime Report" },
	},
}
