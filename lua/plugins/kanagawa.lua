local M = { 'rebelot/kanagawa.nvim' }

M.lazy = false

M.config = function()
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
  })
  vim.cmd.colorscheme('kanagawa')
end

return M
