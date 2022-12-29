local status, barbar = pcall(require, "bufferline")
if not status then
	return
end

-- local nvim_tree_events = require("nvim-tree.events")
-- local nvim_tree_events = require("neo-tree.events")
-- local bufferline_api = require("bufferline.api")
--
-- local function get_tree_size()
-- 	return require("nvim-tree.view").View.width
-- end
--
-- nvim_tree_events.subscribe("TreeOpen", function()
-- 	bufferline_api.set_offset(get_tree_size())
-- end)
--
-- nvim_tree_events.subscribe("Resize", function()
-- 	bufferline_api.set_offset(get_tree_size())
-- end)
--
-- nvim_tree_events.subscribe("TreeClose", function()
-- 	buferline_api.set_offset(0)
-- end)

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			require("bufferline.api").set_offset(40, "FileTree")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("<afile>"):match("neo-tree") then
			require("bufferline.api").set_offset(0)
		end
	end,
})

local config = {
	icon_separator_active = "|",
	icon_separator_inactive = "|",
}

barbar.setup(config)
