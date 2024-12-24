return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- Whether to briefly highlight the node after jumping to it
		highlight_duration = 250, -- How long should above highlight last (in ms)
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.add({
			{ "f", name = "[S]yntax [N]avigation" },
			{ "<C-n>", ":Treewalker Down<CR>", { noremap = true }, desc = "[N]ext [Function" },
			{ "<C-p>", ":Treewalker Up<CR>", { noremap = true }, desc = "[P]rev [F]unction" },
			{ "<C-f>", ":Treewalker Right<CR>", { noremap = true }, desc = "[N]ext [S]ymbol" },
			{ "<C-b>", ":Treewalker Left<CR>", { noremap = true }, desc = "[P]rev [S]ymbol" },

			-- Node swapping
			{ "<C-S-j>", ":Treewalker SwapDown<CR>", { noremap = true }, desc = "[S]wap [D]own" },
			{ "<C-S-k>", ":Treewalker SwapUp<CR>", { noremap = true }, desc = "[S]wap [U]p" },
			{
				"<C-S-l>",
				":TSTextobjectSwapNext @parameter.inner<CR>",
				{ noremap = true },
				desc = "Swap Next Parameter",
			},
			{
				"<C-S-h>",
				":TSTextobjectSwapPrevious @parameter.inner<CR>",
				{ noremap = true },
				desc = "Swap Prev Parameter",
			},
		})
	end,
}
