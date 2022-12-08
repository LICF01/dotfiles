-- import toggleterm plugin safely
local setup, toggleterm = pcall(require, "toggleterm")
if not setup then
	return
end

local config = {
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
}

-- configure/enable gitsigns
toggleterm.setup(config)
