--  Keymaps can be slua require("trouble").next({skip_groups = true, jump = true})et via vim.api.nvim_set_keymap(). It takes 4 arguments: the mode for which the mapping will take effect, the key sequence, the command to execute and a table of options (:h :map-arguments).
--
--  String value 	Help page 	        Affected modes 	                    Vimscript equivalent
--  ''              (an empty string) 	mapmode-nvo 	                    Normal, Visual, Select, Operator-pending 	:map 'n' 	        mapmode-n 	        Normal 	                            :nmap
--  'v' 	        mapmode-v 	        Visual and Select 	                :vmap
-- 's' 	        mapmode-s 	        Select 	                            :smap
--  'x' 	        mapmode-x 	        Visual 	                            :xmap
--  'o' 	        mapmode-o 	        Operator-pending 	                :omap
--  '!' 	        mapmode-ic 	        Insert and Command-line             :map!
--  'i' 	        mapmode-i 	        Insert 	                            :imap
--  'l' 	        mapmode-l 	        Insert, Command-line, Lang-Arg 	    :lmap
--  'c' 	        mapmode-c 	        Command-line 	                    :cmap
--  't' 	        mapmode-t 	        Terminal 	                        :tmap
--
local g = vim.g -- vim.g sets global variables
local map = vim.api.nvim_set_keymap
local wk = require("which-key")

-- map the leader key
g.mapleader = " " -- Sets the leader key

g.toggleterm_terminal_mapping = "<C-t>"

local opts = { noremap = true, silent = true }

map("n", "<leader><esc>", ":nohlsearch<cr>", opts)

-- remaps Esc key to
map("i", "jk", "<Esc>", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window Resize
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
map("n", "<leader>n", ":bnext<cr>", opts)
map("n", "<leader>p", ":bprev<cr>", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Bufferline
map("n", "<leader>gB", ":BufferLinePick<CR>", opts)
map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)

wk.register({
	["<leader>"] = {
		name = "+manage",
		['.'] = {
			[[<cmd>lua require('telescope.builtin').find_files()<cr>]],
			-- ":Telescope find_files<cr>",
			"File",
		},
	},
	["<leader>P"] = {
		name = "+manage",
		s = { ":PackerSync<CR>", "Sync plugins", noremap = false },
		i = { ":PackerInstall<CR>", "Install new plugins", noremap = false },
		u = { ":PackerUpdate<CR>", "Update plugins", noremap = false },
	},
	["<leader>b"] = {
		name = "+buffer",
		f = { ":TZFocus<CR>", "Focus buffer", noremap = true, silent = true },
		b = { ":Neotree buffers", "Project buffers", noremap = true, silent = true },
		B = {
			[[<cmd>lua require('telescope.builtin').buffers()<cr>]],
			"Buffer",
			noremap = true,
			silent = true,
		},
	},
	["<leader>c"] = {
		name = "+code",
		c = {
			name = "+comment",
			s = {
				":lua require('nvim-comment-frame').add_comment()<CR>",
				"Single line Frame comment",
				mode = "n",
				silent = true,
			},
			m = {
				":lua require('nvim-comment-frame').add_multiline_comment()<CR>",
				"Multi line Frame comment",
				mode = "n",
				silent = true,
			},
		},
		f = { ":Format<CR>", "Format", mode = "n", noremap = true, silent = true },
		L = {
			name = "+LspSaga",

			F = {
				":Lspsaga lsp_finder<CR>",
				"Finder",
				mode = "n",
				noremap = true,
				silent = true,
			},
			a = {
				":Lspsaga code_action<CR>",
				"Execute code action",
				mode = "n",
				noremap = true,
				silent = true,
			},
			h = {
				":Lspsaga hover_doc<CR>",
				"Show Doc",
				mode = "n",
				noremap = true,
				silent = true,
			},
			s = {
				":Lspsaga signature_help<cr>",
				"Signature help",
				mode = "n",
				noremap = true,
				silent = true,
			},
			r = {
				":Lspsaga rename<CR>",
				"Rename",
				mode = "n",
				noremap = true,
				silent = true,
			},
			d = {
				":Lspsaga preview_definition<CR>",
				"Preview definition",
				mode = "n",
				noremap = true,
				silent = true,
			},
			o = {
				":Lspsaga show_line_diagnostics<CR>",
				"Show line diagnostics",
				mode = "n",
				noremap = true,
				silent = true,
			},
			n = {
				":Lspsaga diagnostic_jump_next<CR>",
				"Next diagnostic",
				mode = "n",
				noremap = true,
				silent = true,
			},
			p = {
				":Lspsaga diagnostic_jump_prev<CR>",
				"Previous diagnostic",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},

		t = {
			name = "+Telescope",
			a = {
				[[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]],
				"List LSP actions",
				mode = "n",
				noremap = true,
				silent = true,
			},
			d = {
				[[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]],
				"Go or list definitions",
				mode = "n",
				noremap = true,
				silent = true,
			},
			i = {
				[[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]],
				"Goto or list implementation",
				mode = "n",
				noremap = true,
				silent = true,
			},
			r = {
				[[<cmd>lua require('telescope.builtin').lsp_references()<cr>]],
				"List LSP references",
				mode = "n",
				noremap = true,
				silent = true,
			},
			s = {
				[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]],
				"List document symbols in the current buffer",
				mode = "n",
				noremap = true,
				silent = true,
			},
			x = {
				[[<cmd>lua require('telescope.builtin').diagnostics()<cr>]],
				"List diagnostics",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},
	},
	["<leader>f"] = {
		name = "+find",
		b = {
			[[<cmd>lua require('telescope.builtin').buffers()<cr>]],
			"Buffer",
		},
		e = {
			[[:Telescope emoji search<CR>]],
			"Emoji",
		},
		f = {
			[[<cmd>lua require('telescope.builtin').find_files()<cr>]],
			-- ":Telescope find_files<cr>",
			"File",
		},
		g = {
			[[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
			"With grep",
		},
		h = {
			[[<cmd>lua require('telescope.builtin').help_tags()<cr>]],
			"Help tag",
		},
		p = {
			":Telescope project<cr>",
			"Project",
			mode = "n",
			noremap = true,
			silent = true,
		},
	},

	["<leader>g"] = {
		name = "+git",
		t = {
			name = "+Telescope",
			b = {
				[[<cmd>lua require('telescope.builtin').git_branches()<cr>]],
				"List all branches with log preview",
				mode = "n",
				noremap = true,
				silent = true,
			},
			c = {
				[[<cmd>lua require('telescope.builtin').git_commits()<cr>]],
				"List git commits with diff preview",
				mode = "n",
				noremap = true,
				silent = true,
			},
			C = {
				[[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],
				"List git buffer's commits with diff preview",
				mode = "n",
				noremap = true,
				silent = true,
			},
			s = {
				[[<cmd>lua require('telescope.builtin').git_status()<cr>]],
				"List current changes per file",
				mode = "n",
				noremap = true,
				silent = true,
			},
			S = {
				[[<cmd>lua require('telescope.builtin').git_status()<cr>]],
				"List stash items in current repository",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},
	},
	["<leader>o"] = {
		name = "+Open",
		t = {
			":Neotree filesystem reveal left<cr>",
			"Project tree",
			mode = "n",
			noremap = true,
			silent = true,
		},
		l = {
			"<cmd>lua _lazygit_toggle()<CR>",
			"Lazygit",
			mode = "n",
			noremap = true,
			silent = true,
		},
	},
	["<leader>p"] = {
		name = "+project",
		r = {
			":NvimTreeRefresh<cr>",
			"Refresh project tree",
			mode = "n",
			noremap = true,
			silent = true,
		},
		f = {
			":Telescope project<cr>",
			"Find project",
			mode = "n",
			noremap = true,
			silent = true,
		},
		p = {
			":Telescope project<cr>",
			"Find project",
			mode = "n",
			noremap = true,
			silent = true,
		},
	},
	["<leader>t"] = {
		name = "+Toggle",
		z = {
			"<cmd>TZAtaraxis<CR>",
			"Zen mode",
			mode = "n",
			noremap = true,
			silent = true,
		},
		m = {
			":TZMinimalist<CR>",
			"Minimal mode",
			mode = "n",
			noremap = true,
			silent = true,
		},
		l = { ":Twilight<CR>", "Twilight", mode = "n" },
		t = {
			name = "Terminal",
			h = {
				"<cmd>ToggleTerm size=20 direction=horizontal<CR>",
				"Horizontal",
				mode = "n",
				noremap = true,
				silent = true,
			},
			f = {
				"<cmd>ToggleTerm size=20 direction=float<CR>",
				"Float",
				mode = "n",
				noremap = true,
				silent = true,
			},
			v = {
				"<cmd>ToggleTerm size=50 direction=vertical<CR>",
				"Vertical",
				mode = "n",
				noremap = true,
				silent = true,
			},
			t = {
				[[<Cmd>exe v:count1 . "ToggleTerm"<CR>]],
				"Toggle",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},
	},
	["<leader>x"] = {
		name = "diagnostics",
		x = {
			"<cmd>TroubleToggle<cr>",
			"Toggle Trouble",
			noremap = true,
			silent = true,
		},
		w = {
			"<cmd>Trouble workspace_diagnostics<cr>",
			"Workspace diagnostics",
			noremap = true,
			silent = true,
		},
		d = {
			"<cmd>Trouble document_diagnostics<cr>",
			"Document diagnostics",
			noremap = true,
			silent = true,
		},

		l = {
			"<cmd>Trouble loclist<cr>",
			"loclist",
			noremap = true,
			silent = true,
		},
		q = {
			"<cmd>Trouble quickfix<cr>",
			"Show quickfix",
			noremap = true,
			silent = true,
		},
		r = {
			"<cmd>Trouble lsp_references<cr>",
			"Show References",
			noremap = true,
			silent = true,
		},
	},
	["<leader>h"] = {
		name = "+Help",
		t = {
			[[<cmd>lua require('nvim-tree').on_keypress('toggle_help')<cr>]],
			"Show nvim-tree shortcuts",
			noremap = true,
		},
	},
})
