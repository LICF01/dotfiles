local status, onedarkpro = pcall(require, "onedarkpro")
if not status then
	return
end

local oneNordStatus, onenord = pcall(require, "onenord")
if not oneNordStatus then
	return
end

local kanagawaStatus, kanagawa = pcall(require, "kanagawa")
if not status then
	return
end

local nordicStatus, nordic = pcall(require, "nordic")
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
})

onenord.setup({
	disable = {
		background = true, -- Disable setting the background color
		cursorline = true, -- Disable the cursorline
		eob_lines = true, -- Hide the end-of-buffer lines
	},
})

-- Default options:
kanagawa.setup({
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	-- functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	-- typeStyle = {},
	variablebuiltinStyle = { italic = true },
	specialReturn = true, -- special highlight for the return keyword
	specialException = true, -- special highlight for exception handling keywords
	transparent = false, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	globalStatus = false, -- adjust window separators highlight for laststatus=3
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- colors = {},
	-- overrides = {},
	theme = "default", -- Load "default" theme or the experimental "light" theme
})

-- setup must be called before loading
-- vim.cmd("colorscheme kanagawa")

onedarkpro.load()
-- onenord.load()
-- kanagawa.load()
-- nordic.load()
