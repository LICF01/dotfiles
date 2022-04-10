local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "tsserver" then
		local tsserver_opts = require("plugins.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("plugins.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "vscode-html-language-server" then
		local vscode_html_language_server_opts = require("plugins.lsp.settings.vscode_html_language_server")
		opts = vim.tbl_deep_extend("force", vscode_html_language_server_opts, opts)
	end
	if server.name == "emmet-ls" then
		local emmet_ls_opts = require("plugins.lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end
	if server.name == "ccls" then
		local ccls_ls_opts = require("plugins.lsp.settings.ccls")
		opts = vim.tbl_deep_extend("force", ccls_ls_opts, opts)
	end
	if server.name == "clang" then
		local clangd_ls_opts = require("plugins.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_ls_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
