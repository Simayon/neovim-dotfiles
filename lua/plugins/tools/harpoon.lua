return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>h", mode = { "n" }, desc = "+harpoon" },
		{ "<leader>ha", function() require("harpoon"):list():append() end, desc = "Add File" },
		{ "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Menu" },
		{ "<C-p>", function() require("harpoon"):list():prev() end, desc = "Previous File" },
		{ "<C-n>", function() require("harpoon"):list():next() end, desc = "Next File" },
		{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "File 1" },
		{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "File 2" },
		{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "File 3" },
		{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "File 4" },
	},
	config = function()
		require("harpoon"):setup({})
	end,
}
