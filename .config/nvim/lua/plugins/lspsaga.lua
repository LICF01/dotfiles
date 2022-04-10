local M = {}
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd


M.config = function()
    local saga = require 'lspsaga'

    saga.init_lsp_saga {
        finder_definition_icon = '  ',
        finder_reference_icon = '  ',
        max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
        finder_action_keys = {
            open = '<CR>',
            vsplit = 'vs',
            split = 'hs',
            quit = '<C-c>',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>' -- quit can be a table
        }

    }
end

return M
