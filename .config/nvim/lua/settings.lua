local cmd = vim.cmd
local opt = vim.opt -- behaves like :set
local optg = vim.opt_global -- behaves like :setglobal
local optl = vim.opt_local -- behaves like :setlocal
local g = vim.g

-- opt.guifont = "JetBrainsMono Nerd Font:h8"
opt.guifont = "JetBrains Mono:h10"

-- Indentation
opt.expandtab = false -- convert tabs to spaces
opt.tabstop = 4 -- Inset 2 spaces for a tab
opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
opt.smartindent = true -- Do smart autoindenting when starting a new line
opt.autoindent = true -- Copy the indent of the previous line
opt.smarttab = true -- make tab behaviour smarter
optl.colorcolumn = "99999" -- Fix a bug with indent-blankline issue #59

-- completion
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- better completion

-- Clipboard
opt.clipboard = "unnamedplus"

-- UI settings
opt.termguicolors = true -- True color support
opt.cursorline = true -- Highlight the current line
opt.number = true -- Enable line numbers
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 5 -- lines of context
opt.sidescrolloff = 5 -- columns of context
opt.wrap = false -- Disable line wrapping
opt.splitbelow = true -- split below instead of above
opt.splitright = true -- split right instead of left

opt.hlsearch = true -- don't highlight matching search

opt.ignorecase = true -- case insensitive on search..
opt.smartcase = true -- ..unless there's a capital

opt.hidden = true

opt.mouse = "a"

-- nvim-tree
g.nvim_tree_indent_markers = 0
g.nvim_tree_highlight_opened_files = 1

-- Highlight groups settings, to find more see ':h highlight'
--[[ cmd("au VimEnter * highlight Normal guibg=NONE") -- Disables theme bg color
cmd("au VimEnter * highlight Normal ctermbg=NONE") ]]
