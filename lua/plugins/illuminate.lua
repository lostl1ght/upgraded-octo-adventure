local M = { 'RRethy/vim-illuminate' }

M.event = 'BufReadPre'

M.config = function()
  require('illuminate').configure({
    filetypes_denylist = { 'noice', 'registers', 'lir', 'Glance' },
  })
end

return M
