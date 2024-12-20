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
    ██████╗ ██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
    ██╔══██╗██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
    ██████╔╝██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ 
    ██╔═══╝ ██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  
    ██║     ╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   
    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
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
	{ icon = "🔍 ", key = "f", desc = "Find File", action = ":lua require('snacks').dashboard.pick('files')" },
	{ icon = "📄 ", key = "n", desc = "New File", action = ":ene | startinsert" },
	{ icon = "🔎 ", key = "g", desc = "Find Text", action = ":lua require('snacks').dashboard.pick('live_grep')" },
	{ icon = "📂 ", key = "r", desc = "Recent Files", action = ":lua require('snacks').dashboard.pick('oldfiles')" },
	{ icon = "⚙️  ", key = "c", desc = "Config", action = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
	{ icon = "💾 ", key = "s", desc = "Restore Session", section = "session" },
	{ icon = "📦 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
	{ icon = "👋 ", key = "q", desc = "Quit", action = ":qa" },
}

-- Border characters for sections
local border = {
	tl = "╭", tr = "╮", bl = "╰", br = "╯",
	h = "─", v = "│",
}

-- Plugin configuration
return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			width = 80,
			pane_gap = 8,
			sections = {
				-- Header section
				{
					section = "header",
					opts = { header = get_header() },
					padding = { 2, 3 },
				},
				
				-- Left pane sections
				{
					section = "keys",
					items = default_keys,
				},
				{
					section = "startup",
					text = {
						{ "💭 ", hl = "Special" },
						{ get_random_quote(), hl = "Comment", align = "center" },
					},
					padding = { 2, 2 },
					indent = 4,
				},
				
				-- Right pane sections
				{
					pane = 2,
					section = "terminal",
					cmd = "",
					height = 8,
					padding = 2,
				},
				{
					pane = 2,
					icon = "📂 ",
					title = "Recent Files",
					section = "recent_files",
					indent = 4,
					padding = { 2, 2 },
					limit = 8,
				},
				{
					pane = 2,
					icon = "🚀 ",
					title = "Projects",
					section = "projects",
					indent = 4,
					padding = { 2, 2 },
					limit = 8,
				},
				{
					pane = 2,
					icon = "📊 ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return require("snacks").git.get_root() ~= nil
					end,
					cmd = string.format(
						"echo '%s%s%s' && git status --short --branch --renames && echo '%s%s%s'",
						border.tl, string.rep(border.h, 78), border.tr,
						border.bl, string.rep(border.h, 78), border.br
					),
					height = 10,
					padding = { 2, 2 },
					ttl = 5 * 60,
					indent = 4,
				},
				{
					section = "terminal",
					cmd = "",
					height = 8,
					padding = { 2, 2 },
					indent = 4,
				},
			},
			preset = {
				header = get_header(),
				keys = default_keys,
			},
		},
	},
}
