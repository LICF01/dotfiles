-- -- formatting & linting
return {
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
	opts = {
		-- list of formatters & linters for mason to install
		ensure_installed = {
			"prettier", -- ts/js formatter
			"prettierd", -- ts/js formatter
			"stylua", -- lua formatter
			"eslint_d", -- ts/js linter
		},
		-- auto-install configured formatters & linters (with null-ls)
		automatic_installation = true,
	},
}
