-- Border characters for the dashboard
local border = {
	tl = "╭", -- top left
	tr = "╮", -- top right
	bl = "╰", -- bottom left
	br = "╯", -- bottom right
	h = "─", -- horizontal
	v = "│", -- vertical
}

-- Inspirational quotes for the dashboard
local quotes = {
	'"The only way to do great work is to love what you do" - Steve Jobs',
	'"Life is what happens when you\'re busy making other plans" - John Lennon',
	'"The future belongs to those who believe in the beauty of their dreams" - Eleanor Roosevelt',
	'"Success is not final, failure is not fatal: it is the courage to continue that counts" - Winston Churchill',
	'"The only impossible journey is the one you never begin" - Tony Robbins',
	'"Code is like humor. When you have to explain it, it\'s bad." - Cory House',
}

-- Helper functions
local function get_random_quote()
	math.randomseed(os.time())
	return quotes[math.random(#quotes)]
end

-- ASCII art headers for each day of the week
local function get_header()
	local days = {
		[0] = [[
    ███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
    ██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
    ███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝
    ╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝
    ███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║
    ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[1] = [[
    ███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗
    ████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
    ██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝
    ██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝
    ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║
    ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[2] = [[
    ████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
    ╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
       ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝
       ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝
       ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║
       ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[3] = [[
    ██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
    ██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
    ██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝
    ██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝
    ╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║
     ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[4] = [[
    ████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗
    ╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
       ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝
       ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝
       ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║
       ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[5] = [[
    ███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗
    ██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝
    █████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝
    ██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝
    ██║     ██║  ██║██║██████╔╝██║  ██║   ██║
    ╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
		[6] = [[
    ███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗
    ██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
    ███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝
    ╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝
    ███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║
    ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
	}
	local current_day = os.date("*t").wday - 1
	return days[current_day]
end

-- Common keybindings for dashboard
local default_keys = {
	{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
	{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
	{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
	{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
	{
		icon = " ",
		key = "c",
		desc = "Config",
		action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
	},
	{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
	{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
	{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
}

-- Plugin configuration
return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			width = 80,
			pane_gap = 8,
			sections = {
				{
					section = "header",
					text = get_header(),
					hl = "Type",
					position = "center",
					padding = { 4, 3 },
				},
				{
					pane = 2,
					section = "terminal",
					cmd = "cmatrix -b -u 8 -C magenta -s 30",
					height = 15,
					padding = 1,
				},
				{
					section = "keys",
					items = default_keys,
					gap = 1,
					padding = 1,
				},
				{
					pane = 2,
					icon = "📂 ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 1,
					limit = 8,
				},
				{
					pane = 2,
					icon = "🚀 ",
					title = "Projects",
					section = "projects",
					indent = 2,
					padding = 1,
					limit = 8,
				},
				{
					pane = 2,
					icon = "󰊢 ",
					title = "Repository Status",
					section = "terminal",
					enabled = function()
						return require("snacks").git.get_root() ~= nil
					end,
					cmd = "git branch --show-current | xargs -I{} echo '󰘬 Branch: {}' && echo '──────────' && git status --porcelain | sed 's/^M/󰏫 Modified/;s/^A/󰝒 Added/;s/^D/󰗨 Deleted/;s/^R/󰑕 Renamed/' || echo '󰡕 Clean'",
					height = 10,
					padding = { 2, 2 },
					ttl = 5 * 60,
					indent = 4,
					width = 60,
					align = "center",
					border = {
						style = "single",
						text = {
							top = " 󰊢 Git Status ",
							top_align = "center",
						},
					},
					highlights = {
						border = "FloatBorder",
						title = "Function",
						text = "Comment",
					},
				},
				{
					section = "startup",
					text = {
						{ "💭 ", hl = "Special" },
						{ get_random_quote(), hl = "Comment", align = "center" },
					},
					padding = { 1, 1 },
					indent = 2,
				},
			},
			preset = {
				header = get_header(),
				keys = default_keys,
			},
		},
	},
}
