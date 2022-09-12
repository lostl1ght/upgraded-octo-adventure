local hl = require('modules.ui.heirline.colors')
local utils = require('heirline.utils')
local icons = require('modules.ui.heirline.icons').icons

local TabNumber = {
  provider = function(self)
    return string.format('%%%dT %d.%%T', self.tabnr, self.tabnr)
  end,
  hl = hl.Tabpage,
}

local WinModified = {
  condition = function(self)
    return self.has_modified
  end,
  provider = function(self)
    return string.format('%%%dT %s %%T', self.tabnr, icons.small_circle)
  end,
  hl = hl.ModeColors.modified,
}

local WinCount = {
  provider = function(self)
    return string.format(
      '%%%dT %d window%s%%T',
      self.tabnr,
      self.win_count,
      self.win_count == 1 and '' or 's'
    )
  end,
  hl = hl.Tabpage,
}

local TabpageClose = {
  condition = function(self)
    return not self.has_modified
  end,
  provider = function(self)
    return '%' .. self.tabnr .. 'X ' .. icons.cross .. ' %X'
  end,
  hl = hl.Tabpage,
}

local TabPage = {
  init = function(self)
    self.has_modified = false
    local buflist = vim.fn.tabpagebuflist(self.tabnr)
    self.win_count = #buflist
    for _, v in ipairs(buflist) do
      if vim.bo[v].modified then
        self.has_modified = true
        break
      end
    end
  end,
  TabNumber,
  WinCount,
  WinModified,
  TabpageClose,
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = '%=' },
  utils.make_tablist(TabPage),
  { provider = '%=' },
}

local tabline = {
  init = function()
    vim.o.showtabline = 1
  end,
  TabPages,
}

return { TabLine = tabline }
