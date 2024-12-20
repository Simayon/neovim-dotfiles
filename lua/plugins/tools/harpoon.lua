return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		-- Basic keymaps
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end, { desc = "[H]arpoon [A]dd file" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[H]arpoon [H]arpoon Menu" })

		-- Navigation
		vim.keymap.set("n", "<C-p>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon [P]revious file" })

		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():next()
		end, { desc = "Harpoon [N]ext file" })

		-- Quick jumps (1-4)
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon Jump to File 1" })

		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon Jump to File 2" })

		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon Jump to File 3" })

		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon Jump to File 4" })
	end,
}
