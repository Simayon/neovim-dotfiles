-- Theme configuration file with variant support and utilities

-- Generate theme list from colorscheme configs
local function load_theme_files()
	local themes = {}
	local colorscheme_config = require("configs.colorschemes")

	-- Extract theme names from plugin specs
	for _, plugin in ipairs(colorscheme_config) do
		local name = plugin.name or plugin[1]:match(".+/(.+)")
		table.insert(themes, {
			name = name:gsub("[-_]", " "):gsub("^%l", string.upper),
			colorscheme = name,
		})
	end

	-- Sort themes alphabetically for better UX
	table.sort(themes, function(a, b)
		return a.name < b.name
	end)

	return themes
end

-- Theme utility functions
local ThemeUtils = {
	transparency_enabled = false,
}

-- Auto-save theme preference and transparency state
local function save_theme()
	local theme = ThemeUtils.get_current_theme()
	local file = vim.fn.stdpath("data") .. "/last_theme.txt"
	local f = io.open(file, "w")
	if f then
		local data = theme .. "\n" .. (ThemeUtils.transparency_enabled and "1" or "0")
		f:write(data)
		f:close()
	end
end

function ThemeUtils.get_current_theme()
	return vim.g.colors_name or "default"
end

function ThemeUtils.toggle_transparency()
	if not ThemeUtils.transparency_enabled then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		ThemeUtils.transparency_enabled = true
		vim.notify("Transparency enabled", vim.log.levels.INFO)
	else
		local current = ThemeUtils.get_current_theme()
		pcall(vim.cmd.colorscheme, current)
		ThemeUtils.transparency_enabled = false
		vim.notify("Transparency disabled", vim.log.levels.INFO)
	end
	save_theme()
end

function ThemeUtils.random_theme()
	local themes = load_theme_files()
	if #themes > 0 then
		local random_idx = math.random(1, #themes)
		local theme = themes[random_idx].colorscheme
		pcall(vim.cmd.colorscheme, theme)
		vim.notify("Switched to: " .. theme, vim.log.levels.INFO)
	end
end

local function apply_transparency()
	local hl_groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "EndOfBuffer" }
	for _, group in ipairs(hl_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
	ThemeUtils.transparency_enabled = true
end

local function load_saved_theme()
	local file = vim.fn.stdpath("data") .. "/last_theme.txt"
	local f = io.open(file, "r")
	if not f then
		return
	end

	local content = f:read("*all")
	f:close()
	if content == "" then
		return
	end

	local lines = vim.split(content, "\n")
	local theme = lines[1]:gsub("%s+", "")

	local ok = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify("Failed to load saved theme: " .. theme, vim.log.levels.WARN)
		return
	end
end

-- Setup auto-save on ColorScheme change and transparency toggle
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = load_saved_theme,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = save_theme,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = save_theme,
})

return {
	-- Import all colorscheme plugins
	require("configs.colorschemes"),

	-- Enhanced UI components
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { enabled = true },
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
			},
		},
	},

	-- Theme switcher with live preview
	{
		"zaldih/themery.nvim",
		lazy = false,
		priority = 999,
		keys = {
			{ "<leader>t", mode = "n", desc = "+theme" },
			{ "<leader>tt", "<cmd>Themery<cr>", desc = "Switch Theme" },
			{ "<leader>tr", ThemeUtils.random_theme, desc = "Random Theme" },
			{ "<leader>tT", ThemeUtils.toggle_transparency, desc = "Toggle Transparency" },
		},
		init = function()
			-- Load saved theme on startup (before plugins load)
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = load_saved_theme,
			})
		end,
		config = function()
			local themes = load_theme_files()

			require("themery").setup({
				themes = themes,
				livePreview = true,

				-- Reset theme settings before switching
				globalBefore = [[
					vim.cmd("hi clear")
					if vim.g.colors_name then
						vim.cmd("colorscheme " .. vim.g.colors_name)
					end
				]],

				-- Refresh UI plugins after theme change
				globalAfter = [[
					-- Refresh statusline
					if package.loaded["feline"] then
						require("feline").reset_highlights()
					end
					if package.loaded["lualine"] then
						require("lualine").setup()
					end

					-- Refresh bufferline
					if package.loaded["bufferline"] then
						require("bufferline").setup()
					end

					-- Refresh file explorer
					if package.loaded["nvim-tree"] then
						vim.cmd("NvimTreeRefresh")
					end

					-- Clear and redraw
					vim.cmd("redraw!")
				]],
			})
		end,
	},
	-- In your plugin specification
	{
		"tribela/transparent.nvim",
		lazy = false, -- ensure plugin is loaded early
		config = function()
			require("transparent").setup({
				auto = false, -- disable auto so you can control toggle manually
				-- you can also set extra_groups, excludes, etc.
			})

			-- After the plugin is ready, load your saved transparency state
			local function load_saved_transparency()
				local file = vim.fn.stdpath("data") .. "/last_theme.txt"
				local f = io.open(file, "r")
				if not f then
					return
				end
				local content = f:read("*all")
				f:close()
				local lines = vim.split(content, "\n")
				local transparency = lines[2] == "1"

				if transparency then
					vim.cmd("TransparentEnable")
				else
					vim.cmd("TransparentDisable")
				end
			end

			-- call it immediately in config
			load_saved_transparency()
		end,
	},
}
