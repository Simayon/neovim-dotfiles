---@class AutoCommands
---@field setup_neotree function
---@field setup function
local M = {}

-- Error handling helper
---@param callback function
---@return function
local function with_error_handling(callback)
	return function(...)
		local ok, err = pcall(callback, ...)
		if not ok then
			vim.notify("Error in autocommand: " .. tostring(err), vim.log.levels.ERROR)
		end
	end
end

---Setup Neotree autoopen with deferred initialization
---@return nil
M.setup_neotree = function()
	local group = vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })

	-- Function to check if Neotree should be opened
	local function should_open_neotree()
		local buftype = vim.bo.buftype
		local filetype = vim.bo.filetype
		local bufname = vim.fn.expand("%")

		-- Skip Neotree for specific conditions
		if filetype == "dashboard" or filetype == "neo-tree" or bufname == "" then
			return false
		end

		-- Only open for normal buffers
		return buftype == "" and not vim.g.neotree_opened
	end

	-- Function to safely open Neotree
	local function safe_open_neotree()
		if should_open_neotree() then
			vim.schedule(function()
				pcall(function()
					vim.cmd("Neotree show left")
				end)
				vim.g.neotree_opened = true
			end)
		end
	end

	-- Handle initial Vim startup
	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		callback = with_error_handling(function()
			vim.defer_fn(safe_open_neotree, 100)
		end),
	})

	-- Handle opening files after startup
	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = group,
		callback = with_error_handling(function()
			if vim.g.neotree_opened then
				return
			end
			safe_open_neotree()
		end),
	})
end

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

---Initialize all autocommands
---@return nil
M.setup = function()
	-- Profile startup time if requested
	if vim.env.NVIM_PROFILE then
		vim.cmd("profile start profile.log")
		vim.cmd("profile file *")
		vim.cmd("profile func *")
	end

	M.setup_neotree()

	-- Stop profiling if it was started
	if vim.env.NVIM_PROFILE then
		vim.defer_fn(function()
			vim.cmd("profile stop")
		end, 3000) -- Stop profiling after 3 seconds
	end
end

return M
