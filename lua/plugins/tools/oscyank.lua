return {
	"ojroques/vim-oscyank",
	branch = "main",
	config = function()
		-- Key mappings for OSCYank

		-- Optional configurations
		vim.g.oscyank_max_length = 0 -- No limit on selection length
		vim.g.oscyank_silent = 0 -- Show success messages on copy
		vim.g.oscyank_trim = 0 -- Do not trim whitespace when copying

		-- which-key integration
		local wk = require("which-key")
		wk.add({
			{ "<leader>y", { name = "[Y]ank", mode = { "n", "v" } } },
			{ "<leader>y", "<Plug>OSCYankOperator", { desc = "[Y]ank to clipboard (OSC52)", mode = "n" } },
			{ "<leader>yl", "<Plug>OSCYankLine", { desc = "[Y]ank [L]ine to clipboard", mode = "n", remap = true } },
			{ "<leader>y", "<Plug>OSCYankVisual", { desc = "[Y]ank selection to clipboard", mode = "v" } },
		})
	end,
}
