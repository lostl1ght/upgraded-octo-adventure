-- stylua: ignore
local colors = {
  autumnGreen  = 7771242,  -- #76946a
  autumnRed    = 12795971, -- #c34043
  autumnYellow = 14460257, -- #dca561
  crystalBlue  = 8297688,  -- #7e9cd8
  dragonBlue   = 6653332,  -- #658594
  fujiGray     = 7500137,  -- #727169
  fujiWhite    = 14473146, -- #dcd7ba
  lightBlue    = 10736853, -- #a3d4d5
  oldWhite     = 13156499, -- #c8c093
  oniViolet    = 9797560,  -- #957fb8
  peachRed     = 16735586, -- #ff5d62
  roninYellow  = 16752187, -- #ff9e3b
  sakuraPink   = 13794969, -- #d27e99
  samuraiRed   = 15213604, -- #e82424
  sumiInk0     = 1447453,  -- #16161d
  sumiInk1     = 2039592,  -- #1f1f28
  sumiInk2     = 2763319,  -- #2a2a37
  surimiOrange = 16752742, -- #ffa066
  waveAqua2    = 8038559,  -- #7aa89f
}

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

  Recording = {
    fg = colors.roninYellow,
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

return hl
