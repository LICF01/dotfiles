return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim" },
	opts = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		return {
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
			sources = {
				formatting.stylua,
				formatting.prettierd.with({
					extra_filetypes = { "astro" },
				}),
				diagnostics.eslint_d.with({ -- js/ts linter
					-- only enable eslint if root has .eslintrc.js
					condition = function(utils)
						return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
					end,
				}),
			},
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		}
	end,
}
