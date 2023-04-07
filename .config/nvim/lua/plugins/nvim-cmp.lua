return {
	"hrsh7th/nvim-cmp", -- completion plugin
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
	},

	opts = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local merge = function(a, b)
			return vim.tbl_deep_extend("force", {}, a, b)
		end
		return {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- confirm selection
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-y>"] = cmp.mapping.confirm({ select = false }),

				-- navigate items on the list
				["<Up>"] = cmp.mapping.select_prev_item(select_opts),
				["<Down>"] = cmp.mapping.select_next_item(select_opts),
				["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-n>"] = cmp.mapping.select_next_item(select_opts),

				-- scroll up and down in the completion documentation
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),

				-- toggle completion
				["<C-Space>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end), -- show completion suggestions

				-- go to next placeholder in the snippet
				["<C-f>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- go to previous placeholder in the snippet
				["<C-b>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippets
				{ name = "nvim_lsp" }, -- lsp
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			preselect = cmp.PreselectMode.Item,
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"

					return kind
				end,
			},
			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
		}
	end,
}
