local hl = require('modules.ui.heirline.colors')
local util = require('modules.ui.heirline.icons')
local icons = util.icons
local mode_colors = hl.ModeColors
local conditions = require('heirline.conditions')
local heirline = require('heirline.utils')
local devicons = require('nvim-web-devicons')
local hydra = require('hydra.statusline')

local os_sep = package.config:sub(1, 1)

-- Flexible components priorities
local priority = {
  CurrentPath = 60,
  Git = 40,
  WorkDir = 25,
  Lsp = 10,
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

local HydraActive = {
  condition = hydra.is_active,
  heirline.surround({ icons.powerline.left_rounded, icons.powerline.right_rounded }, function() -- color
    return hl.Hydra[hydra.get_color()]
  end, {
    {
      fallthrough = false,
      ReadOnly,
      { provider = icons.circle },
    },
    Space,
    {
      provider = function()
        return hydra.get_name() or 'HYDRA'
      end,
    },
    hl = { fg = hl.StatusLine.bg, force = true },
  }),
}

local VimModeNormal = {
  condition = function(self)
    return self.mode == 'normal' or not conditions.is_active()
  end,
  {
    fallthrough = false,
    HydraActive,
    NormalModeIndicator,
  },
}

local VimModeActive = {
  condition = function(self)
    return conditions.is_active() and self.mode ~= 'normal'
  end,
  hl = { bg = hl.StatusLine.bg },
  heirline.surround({ icons.powerline.left_rounded, icons.powerline.right_rounded }, function(self) -- color
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
      return table.concat({ ' ', self.query, ' [', self.count.current, '/', self.count.total, '] ' })
    end,
    hl = hl.SearchResults,
  },
  Space,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  init = function(self)
    self.filetype = vim.bo.filetype
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    _, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.filetype
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local WorkDir = {
  condition = function(self)
    return self.pwd
  end,
  hl = hl.WorkDir,
  heirline.make_flexible_component(priority.WorkDir, {
    provider = function(self)
      return self.pwd
    end,
  }, {
    provider = function(self)
      return vim.fn.pathshorten(self.pwd)
    end,
  }, null),
}

local CurrentPath = {
  condition = function(self)
    return self.current_path
  end,
  heirline.make_flexible_component(priority.CurrentPath, {
    provider = function(self)
      return self.current_path
    end,
  }, {
    provider = function(self)
      return vim.fn.pathshorten(self.current_path, 2)
    end,
  }, {
    provider = '',
  }),
  hl = hl.CurrentPath,
}

local FileName = {
  provider = function(self)
    return self.filename
  end,
  hl = hl.FileName,
}

local HydraHint = {
  condition = function()
    return hydra.get_hint()
  end,
  provider = hydra.get_hint,
}

local is_banned = function()
  local types = {
    'NvimTree',
    'NeogitStatus',
  }
  for _, v in ipairs(types) do
    if vim.bo.filetype == v then
      return true
    end
  end
  return false
end

local FileNameBlock = {
  {
    fallthrough = false,
    HydraHint,
    {
      condition = function()
        return conditions.is_active() and not is_banned()
      end,
      FileIcon,
      Space,
      FileType,
      Space,
      WorkDir,
      CurrentPath,
      FileName,
    },
    {
      FileIcon,
      Space,
      WorkDir,
    },
  },
  -- This means that the statusline is cut here when there's not enough space.
  { provider = '%<' },
}

local GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.git_status = vim.b.gitsigns_status_dict
  end,
  hl = hl.Git.branch,
  provider = function(self)
    return table.concat({ ' ', self.git_status.head, ' ' })
  end,
}

local GitChanges = {
  condition = function(self)
    if conditions.is_git_repo() then
      self.git_status = vim.b.gitsigns_status_dict
      local has_changes = self.git_status.added ~= 0 or self.git_status.removed ~= 0 or self.git_status.changed ~= 0
      return has_changes
    end
  end,
  {
    provider = function(self)
      local count = self.git_status.added or 0
      return count > 0 and table.concat({ '+', count, ' ' })
    end,
    hl = hl.Git.added,
  },
  {
    provider = function(self)
      local count = self.git_status.changed or 0
      return count > 0 and table.concat({ '~', count, ' ' })
    end,
    hl = hl.Git.changed,
  },
  {
    provider = function(self)
      local count = self.git_status.removed or 0
      return count > 0 and table.concat({ '-', count, ' ' })
    end,
    hl = hl.Git.removed,
  },
  Space,
}

local Git = heirline.make_flexible_component(priority.Git, { GitBranch, GitChanges }, { GitBranch })

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = icons.diagnostic.error,
    warn_icon = icons.diagnostic.warn,
    info_icon = icons.diagnostic.info,
    hint_icon = icons.diagnostic.hint,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      if self.errors > 0 then
        return table.concat({ self.error_icon, self.errors, ' ' })
      end
    end,
    hl = hl.Diagnostic.error,
  },
  {
    provider = function(self)
      if self.warnings > 0 then
        return table.concat({ self.warn_icon, self.warnings, ' ' })
      end
    end,
    hl = hl.Diagnostic.warn,
  },
  {
    provider = function(self)
      if self.info > 0 then
        return table.concat({ self.info_icon, self.info, ' ' })
      end
    end,
    hl = hl.Diagnostic.info,
  },
  {
    provider = function(self)
      if self.hints > 0 then
        return table.concat({ self.hint_icon, self.hints, ' ' })
      end
    end,
    hl = hl.Diagnostic.hint,
  },
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
    for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
      table.insert(names, server.name)
    end
    self.lsp_names = names
  end,
  heirline.make_flexible_component(priority.Lsp, LspServer, LspIndicator),
  hl = hl.LspServer,
}

local Ruler = {
  -- %-2 : make item takes at least 2 cells and be left justified
  -- %l  : current line number
  -- %L  : number of lines in the buffer
  -- %c  : column number
  -- provider = ' %7(%l:%3L%)  %-2c ',
  provider = '%(%l:%L%)  %-2c ',
  hl = { bold = true },
}

local ScrollBar = {
  static = {
    sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = hl.ScrollBar,
}

local Layout = {
  condition = function()
    return vim.o.iminsert == 1
  end,

  provider = function()
    return string.upper(vim.b.keymap_name) .. ' '
  end,
  hl = hl.Layout,
}

local HelpBufferStatusline = {
  condition = function()
    return vim.bo.filetype == 'help'
  end,
  Space,
  VimMode,
  SearchResults,
  FileIcon,
  Space,
  FileType,
  Space,
  {
    provider = function()
      local filename = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(filename, ':t')
    end,
    hl = hl.FileName,
  },
  Align,
  Ruler,
  ScrollBar,
}

local ActiveStatusline = {
  Space,
  VimMode,
  SearchResults,
  FileNameBlock,
  Space,
  Git,
  Align,
  Diagnostics,
  Lsp,
  Layout,
  Ruler,
  ScrollBar,
}

local statusline = {
  init = function(self)
    local pwd = vim.fn.getcwd(0) -- Present working directory.
    local current_path = vim.api.nvim_buf_get_name(0)
    local filename

    if current_path == '' then
      pwd = vim.fn.fnamemodify(pwd, ':~')
      current_path = nil
      filename = ' [No Name]'
    elseif current_path:find(pwd, 1, true) then
      filename = vim.fn.fnamemodify(current_path, ':t')
      current_path = vim.fn.fnamemodify(current_path, ':~:.:h')
      pwd = vim.fn.fnamemodify(pwd, ':~') .. os_sep
      if current_path == '.' then
        current_path = nil
      else
        current_path = current_path .. os_sep
      end
    else
      pwd = nil
      filename = vim.fn.fnamemodify(current_path, ':t')
      current_path = vim.fn.fnamemodify(current_path, ':~:.:h') .. os_sep
    end

    self.pwd = pwd
    self.current_path = current_path -- The opened file path relevant to pwd.
    self.filename = filename
  end,
  fallthrough = false,
  hl = hl.StatusLine,
  HelpBufferStatusline,
  ActiveStatusline,
}

return { StatusLine = statusline }
