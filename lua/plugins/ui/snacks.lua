local quotes = {
	'"The only way to do great work is to love what you do" - Steve Jobs',
	'"Life is what happens when you\'re busy making other plans" - John Lennon',
	'"The future belongs to those who believe in the beauty of their dreams" - Eleanor Roosevelt',
	'"Success is not final, failure is not fatal: it is the courage to continue that counts" - Winston Churchill',
	'"The only impossible journey is the one you never begin" - Tony Robbins',
	'"Code is like humor. When you have to explain it, it\'s bad." - Cory House',
}

-- Function to get a random quote
local function get_random_quote()
	math.randomseed(os.time()) -- Seed the random number generator
	return quotes[math.random(#quotes)]
end

-- Function to get the current day header
local function get_header()
	local days = {
		[0] = [[
     ██████╗ ██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
    ██╔════╝ ██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
    ███████╗ ██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ 
    ╚════██║ ██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  
    ███████║ ╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   
    ╚══════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
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

return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			width = 80, -- Increased overall width
			pane_gap = 8, -- Increased gap between panes
			sections = {
				{
					section = "header",
					opts = {
						header = get_header(),
					},
					padding = { 2, 3 }, -- More padding around header
				},
				{
					pane = 2,
					section = "terminal",
					cmd = "",
					height = 8, -- Increased height
					padding = 2,
				},
				{
					section = "keys",
					gap = 2,
					padding = { 2, 2 },
					indent = 2,
					items = {
						{
							icon = "🔍 ",
							key = "f",
							desc = "Find File",
							action = ":lua require('snacks').dashboard.pick('files')",
						},
						{ icon = "📄 ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = "🔎 ",
							key = "g",
							desc = "Find Text",
							action = ":lua require('snacks').dashboard.pick('live_grep')",
						},
						{
							icon = "📂 ",
							key = "r",
							desc = "Recent Files",
							action = ":lua require('snacks').dashboard.pick('oldfiles')",
						},
						{
							icon = "⚙️  ",
							key = "c",
							desc = "Config",
							action = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = "💾 ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "📦 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = "👋 ", key = "q", desc = "Quit", action = ":qa" },
					},
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
					cmd = "git status --short --branch --renames",
					height = 8,
					padding = { 2, 2 },
					ttl = 5 * 60,
					indent = 4,
				},
				{
					section = "startup",
					padding = { 2, 2 },
					icon = "⚡ ",
				},
				{
					text = {
						{ "💭 ", hl = "Special" },
						{ get_random_quote(), hl = "Comment", align = "center" },
					},
					padding = { 2, 2 },
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
				keys = {
					{
						icon = "🔍 ",
						key = "f",
						desc = "Find File",
						action = ":lua require('snacks').dashboard.pick('files')",
					},
					{ icon = "📄 ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = "🔎 ",
						key = "g",
						desc = "Find Text",
						action = ":lua require('snacks').dashboard.pick('live_grep')",
					},
					{
						icon = "📂 ",
						key = "r",
						desc = "Recent Files",
						action = ":lua require('snacks').dashboard.pick('oldfiles')",
					},
					{
						icon = "⚙️  ",
						key = "c",
						desc = "Config",
						action = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = "💾 ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "📦 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = "👋 ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
	},
}
