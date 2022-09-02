local config = {}

function config.onedark()
  require('onedark').setup({
    style = vim.g.onedark_style,
  })
  require('onedark').load()
end

function config.bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '',
    },
  })
end

function config.heirline()
  local StatusLine = require('modules.ui.heirline.statusline').StatusLine
  local WinBar = require('modules.ui.heirline.winbar').WinBar
  require('heirline').setup(StatusLine, WinBar)
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
    components = {
      'lsp',
    },
  })
end

return config
