return {
	-- lua functions that many plugins use
	"nvim-lua/plenary.nvim",

	-- My plugins here
	-- theme
	"olimorris/onedarkpro.nvim",
	"rmehri01/onenord.nvim",
	"rebelot/kanagawa.nvim",
	"AlexvZyl/nordic.nvim",

	"szw/vim-maximizer",

	-- essential plugins
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",

	-- commenting with gc
	"numToStr/Comment.nvim",

	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"rafamadriz/friendly-snippets", -- useful snippets

	-- configuring lsp servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- auto closing
	{ "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter" }, -- autoclose tags

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- Diagnostics
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- keybindings helpers
	"folke/which-key.nvim",
}
