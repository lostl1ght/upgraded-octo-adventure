local M = { 'windwp/nvim-autopairs' }

M.lazy = false

M.config = function()
  require('nvim-autopairs').setup()
end

return M
