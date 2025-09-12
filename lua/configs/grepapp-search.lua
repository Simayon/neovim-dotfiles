-- GrepApp Search Plugin with Popup Display
-- File: ~/.config/nvim/lua/grepapp-search.lua

local M = {}

-- Configuration
local config = {
  max_results = 100,
  timeout = 30,
  popup_width = 120,
  popup_height = 30,
  max_lines_per_file = 10
}

-- API endpoint
local GREP_APP_API_URL = "https://grep.app/api/search"

-- Utility functions
local function url_encode(str)
  if str then
    str = string.gsub(str, "\n", "\r\n")
    str = string.gsub(str, "([^%w _%%%-%.~])",
      function(c) return string.format("%%%02X", string.byte(c)) end)
    str = string.gsub(str, " ", "%%20")
  end
  return str
end

local function get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

local function get_visual_selection()
  local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  if #lines == 0 then return "" end

  if #lines == 1 then
    return string.sub(lines[1], start_col, end_col)
  end

  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)

  return table.concat(lines, " ")
end

-- HTML parsing function to extract code snippets
local function parse_snippet(snippet)
  local matches = {}

  -- Basic HTML parsing for the snippet
  -- Extract line numbers and content from the HTML structure
  for line_match in snippet:gmatch('<tr.-</tr>') do
    -- Extract line number
    local line_num = line_match:match('<div class="lineno"[^>]*>%s*(%d+)%s*</div>')

    -- Extract line content
    local pre_content = line_match:match('<pre[^>]*>(.-)</pre>')

    if line_num and pre_content and pre_content:find('<mark') then
      -- Remove HTML tags and convert marks to highlights
      local clean_line = pre_content
      clean_line = clean_line:gsub('<mark[^>]*>', '→')
      clean_line = clean_line:gsub('</mark>', '←')
      clean_line = clean_line:gsub('<[^>]*>', '') -- Remove other HTML tags
      clean_line = clean_line:gsub('&lt;', '<')
      clean_line = clean_line:gsub('&gt;', '>')
      clean_line = clean_line:gsub('&amp;', '&')
      clean_line = clean_line:gsub('&quot;', '"')

      matches[tonumber(line_num)] = clean_line
    end
  end

  return matches
end

-- Fetch results from grep.app API
local function fetch_grep_app(query, page, options)
  options = options or {}

  local params = {
    q = url_encode(query),
    page = tostring(page or 1)
  }

  if options.use_regex then
    params.regexp = 'true'
  elseif options.whole_words then
    params.words = 'true'
  end

  if options.case_sensitive then
    params.case = 'true'
  end

  if options.repo_filter then
    params['f.repo.pattern'] = url_encode(options.repo_filter)
  end

  if options.path_filter then
    params['f.path.pattern'] = url_encode(options.path_filter)
  end

  if options.lang_filter then
    params['f.lang'] = url_encode(options.lang_filter)
  end

  -- Build URL with parameters
  local param_string = ""
  for key, value in pairs(params) do
    if param_string ~= "" then
      param_string = param_string .. "&"
    end
    param_string = param_string .. key .. "=" .. value
  end

  local url = GREP_APP_API_URL .. "?" .. param_string

  -- Use curl to make the request
  local curl_cmd = string.format('curl -s --max-time %d "%s"', config.timeout, url)
  local result = vim.fn.system(curl_cmd)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    return nil, "Failed to fetch data from grep.app (exit code: " .. exit_code .. ")"
  end

  -- Parse JSON response
  local ok, data = pcall(vim.fn.json_decode, result)
  if not ok then
    return nil, "Failed to parse JSON response"
  end

  if not data or not data.hits or not data.hits.hits then
    return nil, "Invalid response format"
  end

  local hits = {}
  local total_count = data.facets and data.facets.count or 0

  for _, hit_data in ipairs(data.hits.hits) do
    local repo = hit_data.repo and hit_data.repo.raw
    local path = hit_data.path and hit_data.path.raw
    local snippet = hit_data.content and hit_data.content.snippet

    if repo and path and snippet then
      if not hits[repo] then
        hits[repo] = {}
      end
      if not hits[repo][path] then
        hits[repo][path] = {}
      end

      local parsed_lines = parse_snippet(snippet)
      for line_num, line_content in pairs(parsed_lines) do
        hits[repo][path][line_num] = line_content
      end
    end
  end

  return hits, nil, total_count
end

-- Create popup window
local function create_popup(title, content_lines)
  local width = math.min(config.popup_width, vim.o.columns - 4)
  local height = math.min(config.popup_height, vim.o.lines - 4)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'grepapp')

  -- Calculate window position (centered)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Window options
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = title,
    title_pos = 'center'
  }

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Set window options
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)

  -- Make buffer readonly
  vim.api.nvim_buf_set_option(buf, 'readonly', true)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Set up keymaps for the popup
  local keymaps = {
    ['q'] = '<cmd>close<cr>',
    ['<Esc>'] = '<cmd>close<cr>',
    ['<C-c>'] = '<cmd>close<cr>',
  }

  for key, action in pairs(keymaps) do
    vim.api.nvim_buf_set_keymap(buf, 'n', key, action, {
      noremap = true,
      silent = true,
      nowait = true
    })
  end

  return buf, win
end

-- Format results for display
local function format_results(hits, query, total_count)
  local lines = {}
  local repo_count = 0
  local file_count = 0
  local line_count = 0

  -- Header
  table.insert(lines, "╭─ GrepApp Search Results ─╮")
  table.insert(lines, string.format("│ Query: %s", query))
  table.insert(lines, string.format("│ Total matches: %d", total_count))
  table.insert(lines, "╰─────────────────────────────╯")
  table.insert(lines, "")

  if vim.tbl_isempty(hits) then
    table.insert(lines, "No results found.")
    return lines, 0, 0, 0
  end

  for repo, paths in pairs(hits) do
    repo_count = repo_count + 1
    table.insert(lines, "")
    table.insert(lines, "📁 " .. repo)
    table.insert(lines, string.rep("─", math.min(80, #repo + 3)))

    for path, line_matches in pairs(paths) do
      file_count = file_count + 1
      table.insert(lines, "  📄 " .. path)

      -- Sort line numbers
      local sorted_lines = {}
      for line_num in pairs(line_matches) do
        table.insert(sorted_lines, line_num)
      end
      table.sort(sorted_lines)

      local displayed_lines = 0
      for _, line_num in ipairs(sorted_lines) do
        if displayed_lines >= config.max_lines_per_file then
          table.insert(lines, "    ... (more lines)")
          break
        end

        line_count = line_count + 1
        displayed_lines = displayed_lines + 1
        local line_content = line_matches[line_num]

        -- Format line with number
        local formatted_line = string.format("    %4d: %s", line_num, line_content)
        table.insert(lines, formatted_line)
      end
    end
  end

  -- Footer
  table.insert(lines, "")
  table.insert(lines, "╭─ Summary ─╮")
  table.insert(lines, string.format("│ Repositories: %d", repo_count))
  table.insert(lines, string.format("│ Files: %d", file_count))
  table.insert(lines, string.format("│ Lines: %d", line_count))
  table.insert(lines, "╰───────────╯")
  table.insert(lines, "")
  table.insert(lines, "Press 'q' or <Esc> to close")

  return lines, repo_count, file_count, line_count
end

-- Main search function with popup display
local function search_and_show_popup(query, options)
  if not query or query == "" then
    vim.notify("No search query provided", vim.log.levels.ERROR)
    return
  end

  -- Show loading message
  vim.notify("Searching grep.app for: " .. query, vim.log.levels.INFO)

  -- Perform search
  local hits, error_msg, total_count = fetch_grep_app(query, 1, options)

  if error_msg then
    vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
    return
  end

  -- Format and display results
  local content_lines = format_results(hits, query, total_count or 0)
  local title = "GrepApp: " .. query

  create_popup(title, content_lines)
end

-- Public API functions
function M.search_word(options)
  local word = get_word_under_cursor()
  if word and word ~= "" then
    search_and_show_popup(word, options)
  else
    vim.notify("No word under cursor", vim.log.levels.WARN)
  end
end

function M.search_visual(options)
  local selection = get_visual_selection()
  if selection and selection ~= "" then
    search_and_show_popup(selection, options)
  else
    vim.notify("No text selected", vim.log.levels.WARN)
  end
end

function M.search_input(options)
  vim.ui.input({
    prompt = "Search grep.app: ",
    default = "",
  }, function(input)
    if input and input ~= "" then
      search_and_show_popup(input, options)
    end
  end)
end

function M.search_regex()
  vim.ui.input({
    prompt = "Search grep.app (regex): ",
    default = "",
  }, function(input)
    if input and input ~= "" then
      search_and_show_popup(input, { use_regex = true })
    end
  end)
end

function M.search_with_filters()
  local filters = {}

  vim.ui.input({ prompt = "Query: " }, function(query)
    if not query or query == "" then return end

    vim.ui.input({ prompt = "Repository filter (optional): " }, function(repo)
      if repo and repo ~= "" then filters.repo_filter = repo end

      vim.ui.input({ prompt = "Path filter (optional): " }, function(path)
        if path and path ~= "" then filters.path_filter = path end

        vim.ui.input({ prompt = "Language filter (optional): " }, function(lang)
          if lang and lang ~= "" then filters.lang_filter = lang end

          search_and_show_popup(query, filters)
        end)
      end)
    end)
  end)
end

-- Setup function
function M.setup(opts)
  opts = opts or {}

  -- Merge user config
  config = vim.tbl_deep_extend("force", config, opts.config or {})

  -- Create user commands
  vim.api.nvim_create_user_command("GrepAppWord", function()
    M.search_word()
  end, { desc = "Search word under cursor on grep.app" })

  vim.api.nvim_create_user_command("GrepAppVisual", function()
    M.search_visual()
  end, { range = true, desc = "Search visual selection on grep.app" })

  vim.api.nvim_create_user_command("GrepApp", function()
    M.search_input()
  end, { desc = "Search grep.app with input" })

  vim.api.nvim_create_user_command("GrepAppRegex", function()
    M.search_regex()
  end, { desc = "Search grep.app with regex" })

  vim.api.nvim_create_user_command("GrepAppFilters", function()
    M.search_with_filters()
  end, { desc = "Search grep.app with filters" })

  -- Default keymaps
  local keymaps = opts.keymaps or {
    search_word = "<leader>gw",
    search_visual = "<leader>gv",
    search_input = "<leader>gs",
    search_regex = "<leader>gr",
    search_filters = "<leader>gf",
  }

  for action, keymap in pairs(keymaps) do
    if keymap then
      local mode = (action == "search_visual") and "v" or "n"
      vim.keymap.set(mode, keymap, M[action], {
        desc = "GrepApp: " .. action:gsub("_", " ")
      })
    end
  end

  -- Set up syntax highlighting for grepapp filetype
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "grepapp",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()

      -- Define syntax highlights
      vim.cmd([[
        syntax match GrepAppRepo /📁.*$/
        syntax match GrepAppFile /📄.*$/
        syntax match GrepAppLineNum /\d\+:/
        syntax match GrepAppHighlight /→.*←/
        syntax match GrepAppBorder /[╭╮╯╰─│]/

        highlight link GrepAppRepo Directory
        highlight link GrepAppFile String
        highlight link GrepAppLineNum LineNr
        highlight link GrepAppHighlight Search
        highlight link GrepAppBorder Comment
      ]])
    end
  })

  vim.notify("GrepApp Search plugin loaded!", vim.log.levels.INFO)
end

return M
