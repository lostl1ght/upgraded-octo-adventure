local M = { 'kylechui/nvim-surround' }

M.lazy = false

M.config = function()
  require('nvim-surround').setup()
end

return M
