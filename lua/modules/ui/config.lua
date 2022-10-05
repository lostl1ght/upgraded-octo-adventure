local config = {}

function config.kanagawa()
  local colors = require('kanagawa.colors').setup()
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      CursorLine = { link = 'Visual' },
      LazyGitNormal = { link = 'Normal' },
      LazyGitBorder = { link = 'FloatermBorder' },
      FoldColumn = { fg = colors.sumiInk3 },
    },
  })
  vim.cmd('colorscheme kanagawa')
  vim.api.nvim_set_hl(0, 'MatchParen', { bold = true, underline = true })
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

function config.notifier()
  require('notifier').setup({
    status_width = function()
      return math.floor(vim.o.columns / 3)
    end,
    notify = {
      clear_time = 2500,
    },
  })
end

function config.hydra()
  vim.api.nvim_set_hl(0, 'HydraHint', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'HydraBorder', { link = 'FloatermBorder' })
end

function config.ufo()
  vim.o.foldcolumn = 'auto'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  require('ufo').setup({
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
  })
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
end

function config.illum()
  require('illuminate').configure()
end

function config.langmap_switch()
  require('langmap_switch').setup({ keymap = 'russian-jcukenwin' })
end

return config
