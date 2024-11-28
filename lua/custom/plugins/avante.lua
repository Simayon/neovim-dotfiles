return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = 'gemini', -- Use the custom provider
    vendors = {
      -- Define custom providers here
      ['my-custom-provider'] = {
        endpoint = 'https://api-inference.huggingface.co/models/Qwen/Qwen2.5-Coder-32B-Instruct/v1/chat/completions',
        model = 'Qwen/Qwen2.5-Coder-32B-Instruct',
        api_key_name = 'QWEN_API_KEY',
        parse_curl_args = function(opts, code_opts)
          -- Custom logic to parse cURL arguments
          local payload = {
            model = opts.model,
            messages = {
              { role = 'user', content = code_opts.content or '' },
            },
            max_tokens = 500,
            stream = true,
          }
          local json_payload = vim.json.encode(payload)
          print(json_payload) -- Debug print to check the JSON payload
          return {
            url = opts.endpoint,
            method = 'POST',
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ' .. vim.env[opts.api_key_name],
            },
            data = json_payload,
          }
        end,
        parse_response = function(data_stream, event_state, opts)
          -- Custom logic to parse incoming SSE stream
          local chunks = vim.split(data_stream, '\n', { plain = true })
          for _, chunk in ipairs(chunks) do
            if chunk:match '^data: ' then
              chunk = chunk:sub(7) -- Remove "data: " prefix
              local json_chunk = vim.json.decode(chunk)
              if json_chunk.choices and json_chunk.choices[1] and json_chunk.choices[1].delta and json_chunk.choices[1].delta.content then
                opts.on_chunk(json_chunk.choices[1].delta.content)
              end
              if json_chunk.error then
                opts.on_complete(json_chunk.error.message)
              elseif json_chunk.choices and json_chunk.choices[1] and json_chunk.choices[1].finish_reason then
                opts.on_complete(nil)
              end
            end
          end
        end,
        parse_stream_data = function(data, handler_opts)
          -- Custom logic to parse incoming stream data (if not using SSE)
          -- This is mutually exclusive with parse_response
        end,
      },
    },
    gemini = {
      api_key_name = 'GEMINI_API_KEY',
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        provider = 'gemini', -- Set gemini as the default provider
        auto_suggestions_provider = 'gemini', -- Set gemini as the default auto-suggestions provider
        gemini = {
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
          model = 'gemini-1.5-flash-latest',
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          ['local'] = false,
        },
        behaviour = {
          auto_suggestions = false, -- Experimental stage
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
        },
        mappings = {
          diff = {
            ours = 'co',
            theirs = 'ct',
            all_theirs = 'ca',
            both = 'cb',
            cursor = 'cc',
            next = ']x',
            prev = '[x',
          },
          suggestion = {
            accept = '<M-l>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
          jump = {
            next = ']]',
            prev = '[[',
          },
          submit = {
            normal = '<CR>',
            insert = '<C-s>',
          },
          sidebar = {
            apply_all = 'A',
            apply_cursor = 'a',
            switch_windows = '<Tab>',
            reverse_switch_windows = '<S-Tab>',
          },
        },
        hints = { enabled = true },
        windows = {
          position = 'right', -- the position of the sidebar
          wrap = true, -- similar to vim.o.wrap
          width = 30, -- default % based on available width
          sidebar_header = {
            enabled = true, -- true, false to enable/disable the header
            align = 'center', -- left, center, right for title
            rounded = true,
          },
          input = {
            prefix = '> ',
            height = 8, -- Height of the input window in vertical layout
          },
          edit = {
            border = 'rounded',
            start_insert = true, -- start insert mode when opening the edit window
          },
          ask = {
            floating = false, -- open the 'AvanteAsk' prompt in a floating window
            start_insert = true, -- start insert mode when opening the ask window
            border = 'rounded',
            focus_on_apply = 'ours', -- which diff to focus after applying
          },
        },
        highlights = {
          diff = {
            current = 'DiffText',
            incoming = 'DiffAdd',
          },
        },
        diff = {
          autojump = true,
          list_opener = 'copen',
          override_timeoutlen = 500,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
