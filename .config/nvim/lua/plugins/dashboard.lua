local cmd = vim.cmd
local g = vim.g

local M = {}

M.config = function()
	g.dashboard_default_executive = "telescope"
	g.indent_blankline_filetype_exclude = "dashboard"

	g.dashboard_custom_shortcut = {
		last_session = "SPC s l",
		find_history = "SPC f h",
		find_file = "SPC f f",
		new_file = "SPC c n",
		change_colorscheme = "SPC t c",
		find_word = "SPC f a",
		book_marks = "SPC f b",
	}

	g.dashboard_custom_header = {
		"=================     ===============     ===============   ========  ========",
		"\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
		"||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
		"|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
		"||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
		"|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
		"||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
		"|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
		"||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
		"||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
		"||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
		"||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
		"||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
		"||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
		"||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
		"||.=='    _-'                                                     `' |  /==.||",
		"=='    _-'                        N E O V I M                         \\/   `==",
		"\\   _-'                                                                `-_   /",
		" `''                                                                      ``'",
	}

	-- Highlight groups settings, to find more see ':h highlight'
	cmd("au VimEnter * highlight DashboardShortCut guifg=#e7c787")
	cmd("au VimEnter * highlight DashboardCenter guifg=#FF6C6B")
	cmd("au VimEnter * highlight DashboardHeader guifg=#565c64")
end

return M
