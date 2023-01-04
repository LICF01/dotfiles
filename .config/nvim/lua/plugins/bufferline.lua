local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		indicator = {
			-- icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "underline", --"icon" | "underline" | "none",
		},
		diagnostic = false,
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				text_align = "center", -- "left" | "center" | "right"
				separator = false,
			},
		},
		separator_style = "thick", -- "slant" | "thick" | "thin" | { "any", "any" },
	},
	highlights = {
		fill = {
			bg = "#282C34",
		},
	},
})
