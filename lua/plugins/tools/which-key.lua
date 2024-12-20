return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>x", group = "E[x]ecute" },
			{ "<leader>q", group = "[Q]uickfix" },
			{ "<leader>a", group = "[A]vante" },
			{ "<leader>/", group = "Search" },
			{ "<leader><leader>", group = "Buffers" },
		})
	end,
}
