local null_ls = require("null-ls")

null_ls.setup({
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,

	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			-- extra_args = { "--tab-width", "4", "--use-tabs", "--single-quote", "--jsx-single-quote" },
		}),
		-- null_ls.builtins.formatting.clang_format,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.gitsigns,
	},
})
