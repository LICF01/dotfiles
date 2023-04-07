return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false, -- telescope did only one release, so use HEAD for now

	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",

			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				prompt_position = "top",
			},
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<a-t>"] = function(...)
						return require("trouble.providers.telescope").open_selected_with_trouble(...)
					end,
					["<a-i>"] = function()
						Util.telescope("find_files", { no_ignore = true })()
					end,
					["<a-h>"] = function()
						Util.telescope("find_files", { hidden = true })()
					end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<C-f>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
					["<C-b>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
				},
				n = {
					["q"] = function(...)
						return require("telescope.actions").close(...)
					end,
				},
			},
		},

		pickers = {
			find_files = {
				hidden = true,
			},
		},
	},
}
