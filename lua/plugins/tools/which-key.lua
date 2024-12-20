return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[C]ode", mode = { "n" } },
			{ "<leader>cp", group = "[C]ode [P]aste", mode = { "n" } },
			{ "<leader>d", group = "[D]ocument/[D]imming", mode = { "n", "v" } },
			{ "<leader>dd", desc = "Toggle [D]imming", mode = { "n" } },
			{ "<leader>de", desc = "Toggle [D]imming [E]nable", mode = { "n" } },
			{ "<leader>r", group = "[R]ename", mode = { "n", "v" } },
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>sn", desc = "[S]earch [N]avbuddy", mode = { "n" } },
			{ "<leader>w", group = "[W]orkspace", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle", mode = { "n", "v" } },
			{ "<leader>h", group = "[H]arpoon", mode = { "n" } },
			{ "<leader>g", group = "[G]it", mode = { "n", "v" } },
			{ "<leader>gs", desc = "[G]it [S]tage", mode = { "n" } },
			{ "<leader>gr", desc = "[G]it [R]eset", mode = { "n" } },
			{ "<leader>x", group = "E[x]ecute", mode = { "n" } },
			{ "<leader>q", group = "[Q]uickfix", mode = { "n" } },
			{ "<leader>a", group = "[A]vante", mode = { "n" } },
			{ "<leader>n", group = "[N]otifications", mode = { "n" } },
			{ "<leader>b", group = "[B]reakpoints", mode = { "n" } },
			{ "<leader>/", group = "Search in Buffer", mode = { "n" } },
			{ "<leader><leader>", group = "Buffers", mode = { "n" } },
		})
	end,
}
