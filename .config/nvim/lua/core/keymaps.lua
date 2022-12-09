local wk = require("which-key")

vim.g.mapleader = " "

local keymap = vim.keymap

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader><esc>", ":nohlsearch<cr>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Window Resize
keymap.set("n", "<C-Up>", ":resize +2<CR>")
keymap.set("n", "<C-Down>", ":resize -2<CR>")
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==")
keymap.set("v", "<A-k>", ":m .-2<CR>==")

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

local vmappings = {}
local mappings = {
	b = {
		name = "Buffers",
		f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
	},
	p = {
		name = "Packer",
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	g = {
		name = "Git",
		g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Mason Info" },
		j = {
			vim.diagnostic.goto_next,
			"Next Diagnostic",
		},
		k = {
			vim.diagnostic.goto_prev,
			"Prev Diagnostic",
		},
		q = { vim.diagnostic.setloclist, "Quickfix" },
		r = { vim.lsp.buf.rename, "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<c-r>", "Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		p = {
			"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
	},
	t = {
		name = "Toggle",
		e = { ":NvimTreeToggle<CR>", "File explorer" },
		t = {
			name = "Terminal",
		},
	},
	T = {
		name = "Treesitter",
		i = { ":TSConfigInfo<cr>", "Info" },
	},
	w = {
		name = "Window",
		v = { "<C-w>v", "Split window vertically" },
		h = { "<C-w>h", "Split window horizontally" },
		m = { ":MaximizerToggle<CR>", "Toggle window maximizer" },
		x = { ":close<CR>", "Close current window" },
		["="] = { "<C-w>=", "Reset windows width and height" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

wk.register(mappings, opts)
wk.register(vmappings, vopts)
