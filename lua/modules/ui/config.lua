local config = {}

function config.kanagawa()
  local colors = require('kanagawa.colors').setup()
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      MatchParen = { fg = colors.springGreen, bg = colors.sumiInk3 },
      LspReferenceText = { link = 'MatchParen' },
      CursorLine = { link = 'Visual' },
    },
  })
  vim.cmd('colorscheme kanagawa')
end

function config.heirline()
  local statuline = require('modules.ui.heirline.statusline').StatusLine
  local winbar = require('modules.ui.heirline.winbar').WinBar
  local tabline = require('modules.ui.heirline.tabline').TabLine
  require('heirline').setup(statuline, winbar, tabline)
end

function config.dressing()
  require('dressing').setup({
    input = {
      relative = 'editor',
    },
  })
end

function config.fidget()
  require('fidget').setup({
    window = {
      relative = 'editor',
    },
  })
end

return config
