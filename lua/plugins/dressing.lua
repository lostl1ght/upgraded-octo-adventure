local M = { 'stevearc/dressing.nvim' }

M.event = 'VeryLazy'

M.config = function()
  require('dressing').setup({
    input = {
      relative = 'editor',
    },
  })
end

return M
