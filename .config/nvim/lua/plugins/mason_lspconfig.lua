return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		-- list of servers for mason to install
		ensure_installed = {
			"tsserver",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"graphql",
		},
		-- auto-install configured servers (with lspconfig)
		automatic_installation = true, -- not the same as ensure_installed
	},
}
