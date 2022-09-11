local icons = {}

icons.icons = {
  powerline = {
    left_rounded = '',
    right_rounded = '',
  },
  diagnostic = {
    error = ' ',
    warn = ' ',
    info = ' ',
    hint = ' ',
  },
  padlock = '',
  circle = '',
  small_circle = '●',
  server = '',
  cross = '',
  bufferline = {
    left = ' ',
    right = ' ',
  },
}

icons.mode = setmetatable({
  n = 'normal',
  no = 'op',
  nov = 'op',
  noV = 'op',
  ['no'] = 'op',
  niI = 'normal',
  niR = 'normal',
  niV = 'normal',
  nt = 'normal',
  v = 'visual',
  V = 'visual_lines',
  [''] = 'visual_block',
  s = 'select',
  S = 'select',
  [''] = 'block',
  i = 'insert',
  ic = 'insert',
  ix = 'insert',
  R = 'replace',
  Rc = 'replace',
  Rv = 'v_replace',
  Rx = 'replace',
  c = 'command',
  cv = 'command',
  ce = 'command',
  r = 'enter',
  rm = 'more',
  ['r?'] = 'confirm',
  ['!'] = 'shell',
  t = 'terminal',
  ['null'] = 'none',
}, {
  __call = function(self, raw_mode)
    return self[raw_mode]
  end,
})

icons.mode_lable = {
  normal = 'NORMAL',
  op = 'OP',
  visual = 'VISUAL',
  visual_lines = 'VISUAL LINES',
  visual_block = 'VISUAL BLOCK',
  select = 'SELECT',
  block = 'BLOCK',
  insert = 'INSERT',
  replace = 'REPLACE',
  v_replace = 'V-REPLACE',
  command = 'COMMAND',
  enter = 'ENTER',
  more = 'MORE',
  confirm = 'CONFIRM',
  shell = 'SHELL',
  terminal = 'TERMINAL',
  none = 'NONE',
}

return icons
