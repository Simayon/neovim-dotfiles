-- Theme configuration file
local function load_theme_files()
	local themes = {}
	local colorschemes = require("configs.colorschemes")

	for _, plugin in ipairs(colorschemes) do
		local name = plugin.name
		if not name then
			name = plugin[1]:match(".+/(.+)")
		end

		local theme = {
			name = name:gsub("[-.]", " "):gsub("^%l", string.upper),
			colorscheme = name,
		}

		table.insert(themes, theme)
	end

	return themes
end

return {
	-- Core Theme Plugins
	require("configs.colorschemes"),

	-- UI Enhancements
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	-- Theme Switcher
	{
		"zaldih/themery.nvim",
		lazy = false,
		keys = {
			{ "<leader>t", mode = { "n" }, desc = "+theme" },
			{ "<leader>tt", "<cmd>Themery<cr>", desc = "Switch Theme" },
		},
		config = function()
			local themes = load_theme_files()
			require("themery").setup({
				themes = themes,
				livePreview = true,
				globalBefore = [[
                    -- Reset any existing theme settings
                    vim.cmd("hi clear")
                ]],
				globalAfter = [[
                    -- Refresh UI components after theme change
                    if package.loaded["feline"] then
                        require("feline").reset_highlights()
                    end
                    if package.loaded["bufferline"] then
                        require("bufferline").setup{}
                    end
                ]],
			})
		end,
	},
}
