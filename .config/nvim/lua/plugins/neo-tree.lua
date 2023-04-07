return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	branch = "v2.x",
	opts = {
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},
	},
}
