local status, onedarkpro = pcall(require, "onedarkpro")
if not status then
	return
end

onedarkpro.setup({
	theme = "onedark",
	caching = true,
	options = {
		transparency = true,
		cursorline = true,
		terminal_colors = true,
	},
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "bold,italic",
		strings = "NONE",
		variables = "NONE",
	},
	plugins = {
		all = true,
	},
})

onedarkpro.load()
