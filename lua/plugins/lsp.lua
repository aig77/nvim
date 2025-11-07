local servers = {
	"lua_ls",
	"nixd",
	"rust_analyzer",
	"pyright",
}

local lsp_keymaps = {
	-- { mode(s), key, action, description }
	{ "n", "gd", vim.lsp.buf.definition, "Go to definition" },
	{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
	{ "n", "gi", vim.lsp.buf.implementation, "Go to implementation" },
	{ "n", "gr", vim.lsp.buf.references, "List references" },
	{ "n", "K", vim.lsp.buf.hover, "Hover docs" },
	{ "n", "<C-k>", vim.lsp.buf.signature_help, "Signature help" },
	{ "n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol" },
	{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action" },
	{ "n", "gl", vim.diagnostic.open_float, "Line diagnostics" },
	{ "n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic" },
	{ "n", "]d", vim.diagnostic.goto_next, "Next diagnostic" },
	{
		"n",
		"<leader>f",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format buffer",
	},
	{
		"n",
		"<leader>th",
		function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end,
		"Toggle inlay hints",
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Configure diagnostic display
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 4,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local on_attach = function(client, bufnr)
			-- Enable inlay hints if supported
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end

			-- Auto-format on save for specific filetypes
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr, async = false })
					end,
				})
			end

			for _, map in ipairs(lsp_keymaps) do
				local mode, lhs, rhs, desc = map[1], map[2], map[3], map[4]
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end
		end

		for _, name in ipairs(servers) do
			local opts = { on_attach = on_attach, capabilities = capabilities }
			if name == "lua_ls" then
				opts.settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				}
			elseif name == "rust_analyzer" then
				opts.settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
						},
						procMacro = {
							enable = true,
						},
						inlayHints = {
							bindingModeHints = { enable = true },
							chainingHints = { enable = true },
							closingBraceHints = { enable = true, minLines = 10 },
							closureReturnTypeHints = { enable = "with_block" },
							parameterHints = { enable = true },
							typeHints = { enable = true },
						},
					},
				}
			elseif name == "nixd" then
				opts.settings = {
					nixd = {
						formatting = {
							command = { "alejandra" },
						},
					},
				}
			end
			lspconfig[name].setup(opts)
		end
	end,
}
