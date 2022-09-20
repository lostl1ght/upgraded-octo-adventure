local conditions = require('heirline.conditions')
local icons = require('modules.ui.heirline.icons').icons

local Align = { provider = '%=' }
local Space = setmetatable({ provider = ' ' }, {
  __call = function(_, n)
    return { provider = string.rep(' ', n) }
  end,
})
local null = { provider = '' }

local hl = require('modules.ui.heirline.colors')
local devicons = require('nvim-web-devicons')
local heirline = require('heirline.utils')

local priority = {
  CurrentPath = 10,
  FileIcon = 60,
  FileType = 25,
  Navic = 40,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,
  heirline.make_flexible_component(priority.FileIcon, {
    provider = function(self)
      return self.icon
    end,
  }, { provider = '' }),
  hl = function(self)
    return { fg = self.icon_color }
  end,
  Space,
}

local FileType = {
  init = function(self)
    self.filetype = vim.bo.filetype
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    _, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,
  heirline.make_flexible_component(priority.FileType, {
    provider = function(self)
      return self.filetype
    end,
  }, { provider = '' }),
  hl = function(self)
    return { fg = self.icon_color }
  end,
  Space,
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
  }, null),
  hl = hl.CurrentPath,
}

local FileName = {
  provider = function(self)
    return self.filename
  end,
  hl = hl.FileName,
  Space,
}

local FileModified = {
  condition = function()
    return vim.bo.modified
  end,
  provider = icons.small_circle,
  hl = hl.ModeColors.modified,
  Space,
}

local FileNameBlock = {
  {
    CurrentPath,
    FileName,
    FileIcon,
    FileType,
  },
  { provider = '%<' },
}

local GitChanges = {
  condition = function(self)
    if conditions.is_git_repo() then
      self.git_status = vim.b.gitsigns_status_dict
      local has_changes = self.git_status.added ~= 0
        or self.git_status.removed ~= 0
        or self.git_status.changed ~= 0
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
}

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
  Space,
}

local os_sep = package.config:sub(1, 1)
local winbar = {
  init = function(self)
    local pwd = vim.fn.getcwd(0)
    local current_path = vim.api.nvim_buf_get_name(0)
    local filename

    if current_path == '' then
      current_path = nil
      filename = ' [No Name]'
    elseif current_path:find(pwd, 1, true) then
      filename = vim.fn.fnamemodify(current_path, ':t')
      current_path = vim.fn.fnamemodify(current_path, ':~:.:h')
      if current_path == '.' then
        current_path = nil
      else
        current_path = current_path .. os_sep
      end
    else
      filename = vim.fn.fnamemodify(current_path, ':t')
      current_path = vim.fn.fnamemodify(current_path, ':~:.:h') .. os_sep
    end

    if vim.o.filetype == 'lazygit' or vim.o.filetype == 'rnvimr' then
      self.current_path = nil
    else
      self.current_path = current_path
    end
    if vim.o.filetype == 'lazygit' then
      self.filename = 'Lazygit'
    elseif vim.o.filetype == 'rnvimr' then
      self.filename = 'Ranger'
    else
      self.filename = filename
    end
  end,
  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
        filetype = { '^git.*' },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  {
    Align,
    Diagnostics,
    GitChanges,
    FileNameBlock,
    FileModified,
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'HeirlineInitWinbar',
  callback = function(args)
    local buf = args.buf
    local buftype = vim.tbl_contains({
      'prompt',
      'nofile',
      'help',
      'quickfix',
    }, vim.bo[buf].buftype)
    local filetype = vim.tbl_contains({ 'gitcommit' }, vim.bo[buf].filetype)
    if buftype or filetype then
      vim.opt_local.winbar = nil
    end
  end,
})

return { WinBar = winbar }
