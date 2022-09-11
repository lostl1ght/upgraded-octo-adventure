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

  TablineBufnr = { fg = colors.fujiGray },

  TablineFileFlags = {
    modified = { fg = colors.autumnGreen },
    readonly = { fg = colors.surimiOrange },
  },

  TablineFileNameBlock = function(self)
    if self.is_active then
      return { fg = colors.surimiOrange }
    elseif self.is_visible then
      return { fg = colors.crystalBlue }
    else
      return { fg = colors.fujiGray }
    end
  end,

  TablineCloseButton = { fg = colors.fujiGray },
  TablineBufferBlock = function(self)
    if self.is_active then
      return { bg = colors.sumiInk2 }
    else
      return { bg = colors.sumiInk1 }
    end
  end,

  BufferLine = { fg = colors.fujiGray },

  Tabpage = function(self)
    if not self.is_active then
      return { fg = colors.fujiGray }
    else
      return { fg = colors.fujiWhite }
    end
  end,

  TabpageClose = { fg = colors.fujiGray },

  TabLineOffset = { bg = colors.sumiInk1 },

  Navic = { fg = colors.oldWhite },

  Layout = { fg = colors.samuraiRed },
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
