local palette = require('modules.ui.heirline.palette')
local heirline = require('heirline.utils')

local colors = palette[vim.g.onedark_style]

local hl = {
  StatusLine = {
    fg = heirline.get_highlight('Statusline').fg,
    bg = colors.bg0,
    bold = true,
  },

  ReadOnly = { fg = colors.red },

  WorkDir = { fg = colors.light_grey, bold = true },

  CurrentPath = { fg = heirline.get_highlight('Directory').fg, bold = true },

  FileName = {
    fg = heirline.get_highlight('Statusline').fg,
    bold = true,
  },

  Git = {
    branch = { fg = colors.purple, bold = true },
    added = { fg = colors.green, bold = true },
    changed = { fg = colors.yellow, bold = true },
    removed = { fg = colors.red, bold = true },
  },

  LspIndicator = { fg = colors.blue },
  LspServer = { fg = colors.blue, bold = true },

  Diagnostic = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.blue },
    hint = { fg = colors.bg_blue },
  },

  ScrollBar = {
    bg = colors.grey,
    fg = colors.fg,
  },

  SearchResults = { fg = colors.black, bg = colors.cyan },
}

local mode_colors = {
  normal = colors.fg,
  op = colors.bg_blue,
  insert = colors.bg_blue,
  visual = colors.bg_yellow,
  visual_lines = colors.bg_yellow,
  visual_block = colors.bg_yellow,
  replace = colors.red,
  v_replace = colors.red,
  enter = colors.cyan,
  more = colors.cyan,
  select = colors.purple,
  command = colors.cyan,
  shell = colors.orange,
  terminal = colors.orange,
  none = colors.red,
}

hl.ModeColors = setmetatable({
  normal = { fg = mode_colors.normal },
}, {
  __index = function(_, mode)
    return {
      fg = hl.StatusLine.bg,
      bg = mode_colors[mode],
      bold = true,
    }
  end,
})

local hydra = {
  red = '#f36c62',
  amaranth = '#ff5170',
  teal = '#00aeae',
  pink = '#f173b7',
  blue = '#54b0fd',
}

local theme = {
  colors = colors,
  highlight = hl,
  hydra = hydra,
}

return theme
