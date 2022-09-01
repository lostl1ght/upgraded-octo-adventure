local config = {}

function config.onedark()
  require('onedark').setup({
    style = 'dark',
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

function config.notifier()
  require('notifier').setup({
    status_width = vim.o.columns,
  })
end

function config.dressing()
  require('dressing').setup({
    input = {
      relative = 'win',
    },
  })
end

return config
