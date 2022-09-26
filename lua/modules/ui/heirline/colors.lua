local colors = require('kanagawa.colors').setup()

local hl = {
  -- statusline
  StatusLine = {
    fg = colors.oldWhite,
    bg = colors.sumiInk1,
    bold = true,
  },

  ReadOnly = { fg = colors.samuraiRed },

  SearchResults = { fg = colors.sumiInk0, bg = colors.waveAqua2 },

  WorkDir = { fg = colors.fujiGray, bold = true },

  LspIndicator = { fg = colors.dragonBlue },

  LspServer = { fg = colors.dragonBlue, bold = true },

  Layout = { fg = colors.samuraiRed },

  ScrollBar = {
    bg = colors.sumiInk2,
    fg = colors.oldWhite,
  },

  -- winbar
  CurrentPath = { fg = colors.autumnGreen, bold = true },

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

  Diagnostic = {
    error = { fg = colors.samuraiRed },
    warn = { fg = colors.roninYellow },
    info = { fg = colors.waveAqua1 },
    hint = { fg = colors.dragonBlue },
  },

  -- tabline
  TabNumber = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray }
    else
      return { fg = colors.oldWhite, bold = true }
    end
  end,

  TabpageClose = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray }
    else
      return { fg = colors.oldWhite }
    end
  end,

  VerticalLine = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray }
    else
      return { fg = colors.surimiOrange }
    end
  end,

  WinCount = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray, bold = true }
    else
      return { fg = colors.surimiOrange }
    end
  end,

  ActiveFile = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray }
    else
      return { fg = colors.oldWhite, bold = true }
    end
  end,
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
  confirm = colors.fujiWhite,
  none = colors.autumnRed,
}

hl.ModeColors = setmetatable({
  normal = { fg = mode_colors.normal },
  modified = { fg = colors.peachRed },
}, {
  __index = function(_, mode)
    return {
      fg = hl.StatusLine.bg,
      bg = mode_colors[mode],
      bold = true,
    }
  end,
})

hl.Hydra = {
  red = colors.autumnRed,
  amaranth = colors.samuraiRed,
  teal = colors.lightBlue,
  pink = colors.sakuraPink,
  blue = colors.crystalBlue,
}

return hl
