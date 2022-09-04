local colors = require('kanagawa.colors').setup()

local hl = {
  StatusLine = {
    fg = colors.oldWhite,
    bg = colors.sumiInk2,
    bold = true,
  },

  ReadOnly = { fg = colors.samuraiRed },

  WorkDir = { fg = colors.fujiGray, bold = true },

  CurrentPath = { fg = colors.crystalBlue, bold = true },

  FileName = {
    fg = colors.oldWhite,
    bold = true,
  },

  Git = {
    branch = { fg = colors.oniViolet, bold = true },
    added = { fg = colors.autumnGreen, bold = true },
    changed = { fg = colors.autumnYellow, bold = true },
    removed = { fg = colors.autumnRed, bold = true },
  },

  LspIndicator = { fg = colors.dragonBlue },
  LspServer = { fg = colors.dragonBlue, bold = true },

  Diagnostic = {
    error = { fg = colors.samuraiRed },
    warn = { fg = colors.roninYellow },
    info = { fg = colors.waveAqua1 },
    hint = { fg = colors.dragonBlue },
  },

  ScrollBar = {
    bg = colors.sumiInk2,
    fg = colors.oldWhite,
  },

  SearchResults = { fg = colors.sumiInk0, bg = colors.waveAqua2 },
}

local mode_colors = {
  normal = colors.oldWhite,
  op = colors.crystalBlue,
  insert = colors.autumnGreen,
  visual = colors.autumnYellow,
  visual_lines = colors.autumnYellow,
  visual_block = colors.autumnYellow,
  replace = colors.autumnRed,
  v_replace = colors.autumnRed,
  enter = colors.waveAqua2,
  more = colors.waveAqua2,
  select = colors.oniViolet,
  command = colors.waveAqua2,
  shell = colors.surimiOrange,
  terminal = colors.surimiOrange,
  none = colors.autumnRed,
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
  red = colors.autumnRed,
  amaranth = colors.samuraiRed,
  teal = colors.lightBlue,
  pink = colors.sakuraPink,
  blue = colors.crystalBlue,
}

local theme = {
  colors = colors,
  highlight = hl,
  hydra = hydra,
}

return theme
