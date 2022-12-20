local M = { 'toppair/reach.nvim' }

M.event = 'BufReadPost'

M.config = function()
  require('reach').setup({
    notifications = true,
  })
end

return M
