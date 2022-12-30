local status, barbar = pcall(require, "bufferline")
if not status then
	return
end

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
		-- if vim.fn.expand("<afile>"):match("neo-tree") then
		if vim.bo.filetype == "neo-tree" then
			require("bufferline.api").set_offset(0)
		end
	end,
})

local config = {
	icon_separator_active = "|",
	icon_separator_inactive = "|",
}

barbar.setup(config)
