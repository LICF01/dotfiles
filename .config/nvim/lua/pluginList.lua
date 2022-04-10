local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginsList.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function()
	use({ "wbthomason/packer.nvim", event = "VimEnter" })

	use("nvim-lua/plenary.nvim")

	-- Show indent guides on blank lines
	--
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
		-- config = function() require('plugins.telescope').config() end,
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" }, -- extensions
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
		},
	})

	-- Telescope extensions
	use({ "xiyaowong/telescope-emoji.nvim", before = "telescope.nvim" })
	-- use({ "gbrlsnchs/telescope-lsp-handlers.nvim", before = "telescope.nvim" })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})

	-- Treesitter module extensions
	use({ "romgrk/nvim-treesitter-context" })
	use({ "p00f/nvim-ts-rainbow" })
	use({ "windwp/nvim-ts-autotag" })

	--[[********************************************************************************************]]
	--[[                                         completion                                         ]]
	--[[********************************************************************************************]]

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.nvim-cmp")
		end,
	})
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- this will auto close ( [ {
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.nvim-autopairs")
		end,
	})

	use({ "onsails/lspkind-nvim" })

	-- html auto close tag
	use({
		"alvan/vim-closetag",
		config = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml"
			vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx"
			vim.g.closetag_filetypes = "html,xhtml,phtml"
			vim.g.closetag_xhtml_filetypes = "xhtml,jsx"
			vim.g.closetag_emptyTags_caseSensitive = 1
			vim.g.closetag_shortcut = ">"
			vim.g.closetag_close_shortcut = "<leader>>"
		end,
	})

	--[[********************************************************************************************]]
	--[[                                            lsp                                             ]]
	--[[********************************************************************************************]]

	-- Enables Lsp
	use({
		"neovim/nvim-lspconfig",
	})

	-- simple to use language server installer
	use({ "williamboman/nvim-lsp-installer" })

	-- use({
	-- 	"tami5/lspsaga.nvim",
	-- 	branch = "nvim51",
	-- 	config = function()
	-- 		require("plugins.lspsaga").config()
	-- 	end,
	-- })

	--[[********************************************************************************************]]
	--[[                                          snippets                                          ]]
	--[[********************************************************************************************]]

	-- use("hrsh7th/vim-vsnip")
	-- use('hrsh7th/cmp-vsnip')
	-- use("hrsh7th/vim-vsnip-integ")
	-- use("SirVer/ultisnips")
	-- use("quangnguyen30192/cmp-nvim-ultisnips")

	-- For luasnip users.
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	use("rafamadriz/friendly-snippets")

	--[[********************************************************************************************]]
	--[[                                       Code Formatter                                       ]]
	--[[********************************************************************************************]]
	--
	-- use({
	-- 	"mhartington/formatter.nvim",
	-- 	config = function()
	-- 		require("plugins.formatter")
	-- 	end,
	-- })

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- ColorScheme
	-- use {'navarasu/onedark.nvim'}
	-- use({ "fnune/base16-vim" })
	use({
		"olimorris/onedarkpro.nvim",
		config = function()
			require("plugins.onedarkpro")
		end,
	})

	-- use({
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("plugins.colorizer")
	-- 		vim.cmd("ColorizerReloadAllBuffers")
	-- 	end,
	-- })

	use("ap/vim-css-color")

	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("plugins.dashboard").config()
		end,
	})

	--[[********************************************************************************************]]
	--[[                                       UI components                                        ]]
	--[[********************************************************************************************]]

	-- icons
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.icons")
		end,
	})

	-- File Explorer
	-- use({
	-- 	"kyazdani42/nvim-tree.lua",
	-- 	config = function()
	-- 		require("plugins.nvim-tree")
	-- 	end,
	-- })
	--
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.neo-tree")
		end,
	})

	-- status line
	-- use({
	-- 	"glepnir/galaxyline.nvim",
	-- 	branch = "main",
	-- 	-- your statusline
	-- 	config = function()
	-- 		require("plugins.statusline").config()
	-- 	end,
	-- })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	})

	-- tabline
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- terminal, becuase I want a terminal that can persist inside neovim
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.gitsigns")
		end,
		-- tag = 'release' -- To use the latest release
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.indent_blankline")
		end,
	})

	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})

	-- Enables commentstring based on context
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use({
		"s1n7ax/nvim-comment-frame",
		requires = { { "nvim-treesitter" } },
		config = function()
			require("plugins.nvim-comment-frame").config()
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("plugins.which-key").config()
		end,
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({
		"kristijanhusak/orgmode.nvim",
		config = function()
			require("orgmode").setup({})
		end,
	})

	use({ "ray-x/lsp_signature.nvim" })

	use("Pocco81/TrueZen.nvim")

	use({ "delphinus/vim-firestore" })
end)
