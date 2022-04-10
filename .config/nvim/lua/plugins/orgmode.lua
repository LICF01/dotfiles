local M = {}

M.config = function()

    require('orgmode').setup {
        org_default_notes_file = '~/.org/'
        -- org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
    }

end
return M
