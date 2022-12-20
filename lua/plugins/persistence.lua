local M = { 'folke/persistence.nvim' }

M.event = 'BufReadPre'

M.config = function()
  require('persistence').setup({
    dir = vim.fn.stdpath('cache') .. '/session/',
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  })
end

return M
