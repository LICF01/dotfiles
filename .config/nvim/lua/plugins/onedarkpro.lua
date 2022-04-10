local onedarkpro = require("onedarkpro")

onedarkpro.setup({
	options = {
		cursorline = true,
	},
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "bold,italic",
		strings = "NONE",
		variables = "NONE",
	},
	colors = {
		onedark = {
			-- bg = "#282C34",
			bg = "#21242b",
		},
	},
	hlgroups = {
		NvimTreeOpenedFile = { fg = "#ffffff" },
		NeoTreeFileNameOpened = { fg = "#ffffff" },
		IndentLine = { fg = "#4A4D54" },
	},
})

onedarkpro.load()
