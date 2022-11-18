local hl = require('modules.ui.heirline.colors')
local util = require('modules.ui.heirline.icons')
local icons = util.icons
local mode_colors = hl.ModeColors
local conditions = require('heirline.conditions')
local heirline = require('heirline.utils')

local priority = {
  WorkDir = 60,
  GitBranch = 40,
  Lsp = 30,
  Ruler = 20,
  ScrollBar = 10,
}

local Align = { provider = '%=' }
local Space = setmetatable({ provider = ' ' }, {
  __call = function(_, n)
    return { provider = string.rep(' ', n) }
  end,
})
local null = { provider = '' }

local ReadOnly = {
  condition = function()
    return not vim.bo.modifiable or vim.bo.readonly
  end,
  provider = icons.padlock,
  hl = hl.ReadOnly,
}

local NormalModeIndicator = {
  Space,
  {
    fallthrough = false,
    ReadOnly,
    {
      provider = icons.circle,
      hl = function()
        if vim.bo.modified then
          return mode_colors.modified
        else
          return mode_colors.normal
        end
      end,
    },
  },
  Space,
}

local VimModeNormal = {
  condition = function(self)
    return self.mode == 'normal' or not conditions.is_active()
  end,
  NormalModeIndicator,
}

local VimModeActive = {
  condition = function(self)
    return conditions.is_active() and self.mode ~= 'normal'
  end,
  hl = { bg = hl.StatusLine.bg },
  heirline.surround({ icons.powerline.left_rounded, icons.powerline.right_rounded }, function(self)
    return mode_colors[self.mode].bg
  end, {
    {
      fallthrough = false,
      ReadOnly,
      { provider = icons.circle },
    },
    Space,
    {
      provider = function(self)
        return util.mode_lable[self.mode]
      end,
    },
    hl = function(self)
      return mode_colors[self.mode]
    end,
  }),
}

local VimMode = {
  init = function(self)
    self.mode = util.mode[vim.fn.mode(1)]
  end,
  VimModeActive,
  VimModeNormal,
  Space,
}

local SearchResults = {
  condition = function(self)
    local lines = vim.api.nvim_buf_line_count(0)
    if lines > 50000 then
      return
    end

    local query = vim.fn.getreg('/')
    if query == '' then
      return
    end

    if query:find('@') then
      return
    end

    local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
    local active = false
    if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
      active = true
    end
    if not active then
      return
    end

    query = query:gsub([[^\V]], '')
    query = query:gsub([[\<]], ''):gsub([[\>]], '')

    self.query = query
    self.count = search_count
    return true
  end,
  {
    provider = function(self)
      return table.concat({
        ' ',
        self.query,
        ' [',
        self.count.current,
        '/',
        self.count.total,
        '] ',
      })
    end,
    hl = hl.SearchResults,
  },
  Space,
}

local WorkDir = {
  condition = function(self)
    return self.pwd
  end,
  hl = hl.WorkDir,
  {
    flexible = priority.WorkDir,
    {
      provider = function(self)
        return self.pwd
      end,
    },
    {
      provider = function(self)
        return vim.fn.pathshorten(self.pwd)
      end,
    },
    null,
  },
  Space,
}

local GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.git_status = vim.b.gitsigns_status_dict
  end,
  {
    flexible = priority.GitBranch,
    {
      provider = function(self)
        return table.concat({ ' ', self.git_status.head, ' ' })
      end,
    },
    { provider = '' },
  },
  hl = hl.Git.branch,
}

local LspIndicator = {
  provider = icons.server .. ' ',
  hl = hl.LspIndicator,
}

local LspServer = {
  Space,
  {
    provider = function(self)
      local names = self.lsp_names
      if #names == 1 then
        names = names[1]
      else
        names = table.concat(names, ' ')
      end
      return ' ' .. names
    end,
  },
  Space,
  hl = hl.LspServer,
}

local Lsp = {
  condition = conditions.lsp_attached,
  init = function(self)
    local names = {}
    for _, server in ipairs(vim.lsp.get_active_clients()) do
      table.insert(names, server.name)
    end
    self.lsp_names = names
  end,
  {
    flexible = priority.Lsp,
    LspServer,
    LspIndicator,
  },
  hl = hl.LspServer,
}

local Ruler = {
  -- %-2 : make item takes at least 2 cells and be left justified
  -- %l  : current line number
  -- %L  : number of lines in the buffer
  -- %c  : column number
  -- provider = ' %7(%l:%3L%)  %-2c ',
  {
    flexible = priority.Ruler,
    {
      provider = '%(%l:%L%)  %-2c ',
    },
    null,
  },
  hl = { bold = true },
}

local ScrollBar = {
  static = {
    sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁' },
  },
  {
    flexible = priority.ScrollBar,
    {
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
      end,
    },
    null,
  },
  hl = hl.ScrollBar,
  Space,
}

local Layout = {
  condition = require('langmap_switch').condition,
  provider = require('langmap_switch').provider,
  hl = hl.Layout,
  Space,
}

local Recording = {
  condition = require('noice').api.status.mode.has,
  provider = require('noice').api.status.mode.get,
  hl = hl.Recording,
  Space,
}

local statusline = {
  init = function(self)
    local current_path = vim.api.nvim_buf_get_name(0)

    self.pwd = vim.fn.fnamemodify(vim.loop.cwd(), ':~')
    self.filename = vim.fn.fnamemodify(current_path, ':t')
  end,
  hl = hl.StatusLine,
  Space,
  VimMode,
  SearchResults,
  WorkDir,
  GitBranch,
  Align,
  Recording,
  Lsp,
  Layout,
  Ruler,
  ScrollBar,
}

return { StatusLine = statusline }
