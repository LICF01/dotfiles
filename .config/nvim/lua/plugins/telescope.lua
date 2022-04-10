local cmd = vim.cmd
local telescope = require("telescope")

telescope.load_extension("media_files")
telescope.load_extension("project")
telescope.load_extension("emoji")
-- telescope.load_extension("lsp_handlers")

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},

		mappings = {
			--[[ i = {
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up
                },
                n = {
                    ["jk"] = actions.close,
                    ["q"] = actions.close,
                    ["<C-c>"] = actions.close,
                    ["<C-j>"] = actions.preview_scrolling_down,
                    ["<C-k>"] = actions.preview_scrolling_up
                } ]]
		},
	},
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
		-- lsp_handlers = {
		-- 	code_action = {
		-- 		telescope = require("telescope.themes").get_dropdown({}),
		-- 	},
		-- },
	},
})
