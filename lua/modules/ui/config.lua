local config = {}

function config.kanagawa()
  local colors = require('kanagawa.colors').setup()
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      NeogitHunkHeader = { bg = colors.diff.text },
      NeogitHunkHeaderHighlight = { fg = colors.git.changed, bg = colors.diff.text },
      NeogitDiffContextHighlight = { bg = colors.diff.change },
      NeogitDiffDeleteHighlight = { fg = colors.git.removed, bg = colors.diff.delete },
      NeogitDiffAddHighlight = { fg = colors.git.added, bg = colors.diff.add },
      MatchParen = { fg = colors.springGreen, bg = colors.sumiInk3 },
      LspReferenceText = { link = 'MatchParen' },
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
