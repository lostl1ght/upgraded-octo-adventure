local M = { 'rebelot/heirline.nvim' }

M.lazy = false

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
  { 'nvim-langmap-switch', dev = true },
  'folke/noice.nvim',
  'SmiteshP/nvim-navic',
}

M.config = function ()
  local statuline = require('plugins.heirline.statusline').StatusLine
  local winbar = require('plugins.heirline.winbar').WinBar
  local tabline = require('plugins.heirline.tabline').TabLine
  require('heirline').setup(statuline, winbar, tabline)
end

return M
