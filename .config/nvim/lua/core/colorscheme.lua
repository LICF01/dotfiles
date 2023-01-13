local status, onedarkpro = pcall(require, "onedarkpro")
if not status then
	return
end

local status, onenord = pcall(require, "onenord")
if not status then
	return
end

onedarkpro.setup({
	theme = "onedark",
	caching = true,
	-- colors = {
	-- 	onedark = {
	-- 		bg = "#1E2127", -- yellow
	-- 	},
	-- },
	options = {
		transparency = false,
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
})

onenord.setup({
	disable = {
		background = true, -- Disable setting the background color
		cursorline = true, -- Disable the cursorline
		eob_lines = true, -- Hide the end-of-buffer lines
	},
})

onedarkpro.load()
-- onenord.load()
