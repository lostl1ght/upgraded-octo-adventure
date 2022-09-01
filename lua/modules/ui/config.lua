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

function config.smart_splits()
  require('bufresize').setup()
  require('smart-splits').setup({
    resize_mode = {
      hooks = {
        on_leave = require('bufresize').register,
      },
    },
  })
end

function config.winshift()
  require('winshift').setup({
    keymaps = {
      disable_defaults = true,
    },
  })
end

function config.dashboard()
  local header = {
    '      .            .      ',
    "    .,;'           :,.    ",
    '  .,;;;,,.         ccc;.  ',
    ".;c::::,,,'        ccccc: ",
    '.::cc::,,,,,.      cccccc.',
    ".cccccc;;;;;;'     llllll.",
    '.cccccc.,;;;;;;.   llllll.',
    ".cccccc  ';;;;;;'  oooooo.",
    "'lllllc   .;;;;;;;.oooooo'",
    "'lllllc     ,::::::looooo'",
    "'llllll      .:::::lloddd'",
    '.looool       .;::coooodo.',
    "  .cool         'ccoooc.  ",
    '    .co          .:o:.    ',
    "      .           .'      ",
  }

  local center = {
    {
      icon = ' ',
      desc = 'Last session',
      action = '',
    },
    {
      icon = ' ',
      desc = 'Load session',
      action = '',
    },
    {
      icon = ' ',
      desc = 'Find file   ',
      action = 'Telescope fd',
    },
    {
      icon = ' ',
      desc = 'New file    ',
      action = 'DashboardNewFile',
    },
    {
      icon = ' ',
      desc = 'Quit        ',
      action = 'qa',
    },
  }
  local footer = function()
    local v = vim.version()
    local f = {
      string.format('neovim v%d.%d.%d%s', v.major, v.minor, v.patch, v.prerelease and ' PRERELEASE' or ''),
    }
    if packer_plugins then
      local count = #vim.tbl_keys(packer_plugins)
      f[2] = count ~= 1 and count .. ' plugins have been loaded' or '1 plugin has been loaded'
    end
    return f
  end
  local db = require('dashboard')
  db.custom_header = header
  db.custom_center = center
  db.custom_footer = footer
  db.header_pad = 3
  db.center_pad = 3
  db.footer_pad = 3
  db.session_directory = vim.fn.stdpath('data') .. '/sessions'
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
