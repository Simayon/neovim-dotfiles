-- ============================================================================
-- LSP (Language Server Protocol) Configuration
-- ============================================================================
-- This configuration sets up language servers for code intelligence features
-- like autocompletion, go-to-definition, diagnostics, and more.

return {
	-- Main LSP configuration plugin
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Mason: Package manager for LSP servers, formatters, and linters
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration for Neovim development
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		},
		config = function()
			-- ================================================================
			-- LSP Attach Autocommand
			-- ================================================================
			-- This runs whenever an LSP attaches to a buffer
			-- It sets up buffer-local keymaps and configurations
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- Helper function to create keymaps more easily
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- ========================================================
					-- LSP Navigation Keymaps
					-- ========================================================
					-- Jump to the definition of the word under cursor
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under cursor
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under cursor
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type definition of the word under cursor
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all symbols in current document
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all symbols in current workspace
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under cursor
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action (like quick fixes)
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Show documentation for what's under cursor
					-- Close diagnostic float before showing hover to avoid overlap
					map("K", function()
						vim.defer_fn(function()
							vim.lsp.buf.hover()
						end, 10)
					end, "Hover Documentation")

					-- Show signature help (function parameters while typing)
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

					-- Jump to declaration (not all language servers support this)
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- ========================================================
					-- Highlight References
					-- ========================================================
					-- Highlight references of the word under cursor when idle
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						-- Highlight references when cursor stops moving
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						-- Clear highlights when cursor moves
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						-- Clean up when LSP detaches
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- ========================================================
					-- Inlay Hints
					-- ========================================================
					-- Toggle inlay hints (type annotations shown inline)
					if client and client.server_capabilities.documentHighlightProvider then
						map("<leader>th", function()
							local bufnr = event.buf
							local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
							vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- ================================================================
			-- LSP Capabilities
			-- ================================================================
			-- Broadcast additional completion capabilities to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- Check which completion plugin is available and use its capabilities
			local has_blink, blink = pcall(require, "blink.cmp")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

			if has_blink then
				-- Using blink.cmp
				capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
			elseif has_cmp then
				-- Using nvim-cmp
				capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
			end

			-- ================================================================
			-- Server Configurations
			-- ================================================================
			-- Define all LSP servers and their specific configurations
			local servers = {
				-- C/C++ Language Server
				clangd = {
					-- Override the default list of filetypes
					filetypes = { "c", "cpp", "objc", "objcpp", "h" },
				},

				-- Lua Language Server
				lua_ls = {
					settings = {
						html = {
							format = {
								templating = true,
								wrapLineLength = 120,
								wrapAttributes = "auto",
							},
							hover = {
								documentation = true,
								references = true,
							},
						},
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- Disable noisy "missing-fields" warnings
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},

				-- QML Language Server
				qmlls = {
					-- Command to start the server
					cmd = { "qmlls" },
					-- File types this server handles
					filetypes = { "qml", "qmljs" },
					-- Function to determine the root directory of the project
					root_dir = function(fname)
						-- Look for .git directory going upward from current file
						local found = vim.fs.find(".git", { path = fname, upward = true })[1]
						-- Return the directory containing .git, or fall back to current working directory
						return found and vim.fs.dirname(found) or vim.fn.getcwd()
					end,
					-- Allow running on single files without a project
					single_file_support = true,
				},

				-- Add more servers here as needed:
				-- gopls = {},        -- Go
				-- pyright = {},      -- Python
				-- rust_analyzer = {}, -- Rust
				-- tsserver = {},     -- TypeScript/JavaScript
			}

			-- ================================================================
			-- Mason Setup
			-- ================================================================
			-- Mason is a package manager for LSP servers and tools
			require("mason").setup()

			-- Automatically install all servers defined in the 'servers' table
			local ensure_installed = vim.tbl_keys(servers or {})
			-- Add additional tools that aren't LSP servers
			vim.list_extend(ensure_installed, {
				"stylua", -- Lua code formatter
			})

			-- Install the tools
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- ================================================================
			-- Server Initialization
			-- ================================================================
			-- Set up each server with mason-lspconfig
			require("mason-lspconfig").setup({
				handlers = {
					-- Default handler for all servers
					function(server_name)
						-- Get the configuration for this server
						local server = servers[server_name] or {}
						-- Merge capabilities with any server-specific capabilities
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						-- Start the server with lspconfig
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- ================================================================
			-- Diagnostics Configuration
			-- ================================================================
			-- Configure how diagnostics (errors, warnings, etc.) are displayed
			vim.diagnostic.config({
				-- Don't show diagnostic messages inline (only on hover)
				virtual_text = false,
				-- Show diagnostic signs in the gutter (left margin)
				signs = true,
				-- Underline problematic code
				underline = true,
				-- Don't update diagnostics while typing (less distracting)
				update_in_insert = false,
				-- Sort diagnostics by severity (errors first)
				severity_sort = true,
				-- Configure floating diagnostic windows
				float = {
					border = "rounded", -- Rounded border style
					source = true, -- Show the source (e.g., "qmlls", "clangd")
					header = "", -- No header text
					prefix = "", -- No prefix before each diagnostic
					-- Position diagnostics at the top to avoid overlap with hover docs
					anchor = "NW",
					style = "minimal",
					focusable = false,
				},
			})

			-- ================================================================
			-- Diagnostic Signs (Icons in Gutter)
			-- ================================================================
			-- Customize the icons shown in the gutter for each diagnostic type
			-- Using diagnostic config signs (nvim 0.10+ preferred method)
			if vim.fn.has("nvim-0.10") == 1 then
				-- Modern way for nvim 0.10+
				vim.diagnostic.config({
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "󰅚 ",
							[vim.diagnostic.severity.WARN] = "󰀪 ",
							[vim.diagnostic.severity.HINT] = "󰌶 ",
							[vim.diagnostic.severity.INFO] = " ",
						},
					},
				})
			else
				-- Fallback for older versions
				local signs = {
					Error = "󰅚 ",
					Warn = "󰀪 ",
					Hint = "󰌶 ",
					Info = " ",
				}
				for type, icon in pairs(signs) do
					local hl = "DiagnosticSign" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end
			end

			-- ================================================================
			-- Auto-show Diagnostics on Hover (Optional)
			-- ================================================================
			-- DISABLED BY DEFAULT to prevent overlap with hover documentation
			-- Uncomment the section below if you want auto-show diagnostics
			-- Otherwise, use <leader>df to manually show diagnostics

			--[[
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
				end,
			})
			--]]

			-- Set how long to wait (in milliseconds) before triggering CursorHold events
			-- Lower value = diagnostics appear faster
			vim.opt.updatetime = 250

			-- ================================================================
			-- Diagnostic Navigation Keymaps
			-- ================================================================
			-- Navigate between diagnostics
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({
					count = -1, -- Jump backward 1 diagnostic
					float = true, -- Show diagnostic in floating window
					wrap = true, -- Wrap around at end of buffer
				})
			end, { desc = "Go to previous diagnostic" })

			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({
					count = 1, -- Jump forward 1 diagnostic
					float = true, -- Show diagnostic in floating window
					wrap = true, -- Wrap around at end of buffer
				})
			end, { desc = "Go to next diagnostic" })

			-- Jump to previous/next ERROR only
			vim.keymap.set("n", "[e", function()
				vim.diagnostic.jump({
					count = -1,
					float = true,
					severity = vim.diagnostic.severity.ERROR,
					wrap = true,
				})
			end, { desc = "Go to previous error" })

			vim.keymap.set("n", "]e", function()
				vim.diagnostic.jump({
					count = 1,
					float = true,
					severity = vim.diagnostic.severity.ERROR,
					wrap = true,
				})
			end, { desc = "Go to next error" })

			-- Jump to previous/next WARNING only
			vim.keymap.set("n", "[w", function()
				vim.diagnostic.jump({
					count = -1,
					float = true,
					severity = vim.diagnostic.severity.WARN,
					wrap = true,
				})
			end, { desc = "Go to previous warning" })

			vim.keymap.set("n", "]w", function()
				vim.diagnostic.jump({
					count = 1,
					float = true,
					severity = vim.diagnostic.severity.WARN,
					wrap = true,
				})
			end, { desc = "Go to next warning" })

			-- View diagnostics in different ways
			vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "[D]iagnostics [F]loat" })
			vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "[D]iagnostics [L]ocation list" })

			-- ================================================================
			-- Diagnostic Toggle Keymaps
			-- ================================================================
			-- Track whether diagnostics are currently enabled
			local diagnostics_active = true

			-- Toggle all diagnostics on/off
			vim.keymap.set("n", "<leader>td", function()
				diagnostics_active = not diagnostics_active
				if diagnostics_active then
					vim.diagnostic.enable()
				else
					vim.diagnostic.enable(false)
				end
			end, { desc = "[T]oggle [D]iagnostics" })

			-- Toggle only the inline virtual text (keep signs and underlines)
			vim.keymap.set("n", "<leader>tv", function()
				local config = vim.diagnostic.config()
				vim.diagnostic.config({ virtual_text = (config ~= nil) and config.virtual_text or nil })
			end, { desc = "[T]oggle [V]irtual text" })
		end,
	},
}
