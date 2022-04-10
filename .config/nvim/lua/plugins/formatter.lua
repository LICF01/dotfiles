require("formatter").setup({
	logging = false,
	filetype = {
		html = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
					},
					stdin = true,
				}
			end,
		},
		css = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--single-quote",
					},
					stdin = true,
				}
			end,
		},

		javascript = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--single-quote",
					},
					stdin = true,
				}
			end,
		},
		javascriptreact = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--single-quote",
					},
					stdin = true,
				}
			end,
		},
		lua = {

			-- luafmt
			--[[ function()
                    return {
                        exe = "lua-format",
                        -- args = {"--indent-count", 2, "--stdin"},
                        stdin = true
                    }
                end ]]
			--[[ function()
                    return {
                        exe = "stylua",
						args = {
                            vim.api.nvim_buf_get_name(0)
						},
                        stdin = true
                    }
                end ]]

			function()
				return {
					exe = "stylua",
					args = {
						--[[ "--config-path "
					  .. os.getenv("XDG_CONFIG_HOME")
					  .. "/stylua/stylua.toml", ]]
						"-",
					},
					stdin = true,
				}
			end,
		},
		cpp = {
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = {},
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
	},
})
