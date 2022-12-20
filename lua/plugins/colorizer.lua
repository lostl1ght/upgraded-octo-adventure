local M = { 'NvChad/nvim-colorizer.lua' }

M.cmd = 'ColorizerToggle'

M.config = function()
  require('colorizer').setup({
    filetypes = { '*' },
    user_default_options = {
      RGB = false,
      RRGGBB = true,
      names = false,
    },
  })
end

return M
