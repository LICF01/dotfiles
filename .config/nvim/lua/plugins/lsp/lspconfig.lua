-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local wk = require("which-key")

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = {
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps}
	}

	wk.register({
		c = {
			name = "Code",
			a = { "<cmd>Lspsaga code_action<cr>", "Definition" },
			d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
			D = { "<cmd>Telescope lsp_type_definitons<cr>", "Type definition" },
			h = { "<cmd>Lspsaga hover_doc<CR>", "Documentation" },
			i = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
			o = { "<cmd>LSoutlineToggle<CR>", "Open Outline sidebar" },
			r = { "<cmd>Telescope lsp_references<cr>", "References" },
			R = { "<cmd>Lspsaga rename<cr>", "Rename symbol" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
			S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols" },
		},
		x = {
			name = "Diagnostics",
			c = { "<cmd>Lspsaga show_cursor_diagnostics<cr>", "show cursor diagnostics" },
			d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Show document diagnostics" },
			k = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev diagnostic" },
			j = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
			l = { "<cmd>Lspsaga show_line_diagnostics<cr>", "show current line diagnostics" },
			L = { "<cmd>TroubleToggle loclist<cr>", "Show loclist" },
			q = { "<cmd>TroubleToggle quickfix<cr>", "Show quickfix objects" },
			x = { "<cmd>TroubleToggle<cr>", "Show diagnostics" },
			X = { "<cmd>Telescope diagnostics<cr>", "List all diagnostics (Telescope)" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Show workspace diagnostics" },
		},
	}, {
		prefix = "<leader>",
		mode = "n", -- NORMAL mode
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps}
	})

	wk.register({
		f = { "<cmd>Lspsaga lsp_finder<CR>", "Lsp finder" },
		d = { "<cmd>Lspsaga peek_definition<CR>", "Show definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Show declaration" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Show implementation" },
		r = { "<cmd>Telescope lsp_references<cr>", "Find references" },
	}, {
		prefix = "g",
		mode = "n", -- NORMAL mode
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps}
	})

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		wk.register({
			c = {
				name = "Code",
				t = {
					name = "Typescript ",
					r = { ":TypescriptRenameFile<CR>", "Rename file and update imports" },
					i = { ":TypescriptOrganizeImports<CR>", "Organize imports" },
					x = { ":TypescriptRemoveUnused<CR>", "Remove unused variables" },
				},
			},
		}, {
			prefix = "<leader>",
			mode = "n", -- NORMAL mode
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps}
		})
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "astro" },
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- -- configure emmet language server
-- lspconfig["emmet_ls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["astro"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false, -- Disables the inline diagnostic text, doesn't hide the indicators
})
