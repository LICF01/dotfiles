local setup, indentBlankline = pcall(require, "indent_blankline")
if not setup then
	return
end

local config = {
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
}

-- configure/enable gitsigns
indentBlankline.setup(config)
