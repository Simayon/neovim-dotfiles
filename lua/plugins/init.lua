-- Load all plugin modules
local M = {}

-- Check if a table is a list (array)
local function is_list(t)
    if type(t) ~= "table" then return false end
    local count = 0
    for k, _ in pairs(t) do
        count = count + 1
        if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
            return false
        end
    end
    for i = 1, count do
        if t[i] == nil then return false end
    end
    return true
end

-- Scan directory for Lua files
local function scan_dir(dir)
    local plugins = {}
    local handle = vim.loop.fs_scandir(dir)
    if handle then
        while true do
            local name, file_type = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end

            local full_path = dir .. "/" .. name
            if file_type == "directory" then
                -- Recursively scan subdirectories
                local sub_plugins = scan_dir(full_path)
                vim.list_extend(plugins, sub_plugins)
            elseif file_type == "file" and name:match("%.lua$") and name ~= "init.lua" then
                -- Convert file path to require path
                local require_path = full_path:match("lua/(.+)%.lua$"):gsub("/", ".")
                local ok, module = pcall(require, require_path)
                if ok and module then
                    if type(module) == "table" then
                        if is_list(module) then
                            vim.list_extend(plugins, module)
                        else
                            table.insert(plugins, module)
                        end
                    else
                        table.insert(plugins, module)
                    end
                end
            end
        end
    end
    return plugins
end

-- Get the absolute path of the plugins directory
local plugins_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

-- Load all plugins
local all_plugins = scan_dir(plugins_dir)

return all_plugins
