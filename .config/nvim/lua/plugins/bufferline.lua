local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		indicator = {
			-- icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "none", --"icon" | "underline" | "none",
		},
		diagnostic = false,
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				text_align = "center", -- "left" | "center" | "right"
				separator = true,
			},
		},
		separator_style = "thick", -- "slant" | "thick" | "thin" | { "any", "any" },
	},
	highlights = {
		fill = {
			fg = "#EC5F67",
			bg = "#22262D",
		},
		indicator_selected = {
			fg = "#EC5F67",
		},
		separator_selected = {
			fg = "#22262D",
		},
		separator_visible = {
			fg = "#22262D",
		},
		separator = {
			fg = "#22262D",
		},
		offset_separator = {
			bg = "#282c34",
		},
	},
})
