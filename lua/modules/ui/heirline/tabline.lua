local hl = require('modules.ui.heirline.colors')
local utils = require('heirline.utils')
local icons = require('modules.ui.heirline.icons').icons

local VerticalLine = {
  provider = '│',
  hl = hl.VerticalLine,
}

local TabNumber = {
  provider = function(self)
    return string.format('%%%dT %d. %%T', self.tabnr, self.tabnr)
  end,
  hl = hl.Tabpage,
}

local WinCount = {
  condition = function(self)
    return self.win_count > 1
  end,
  provider = function(self)
    return string.format('%%%dT [%d]%%T', self.tabnr, self.win_count)
  end,
  hl = hl.WinCount,
}

local ActiveFile = {
  provider = function(self)
    return string.format('%%%dT%s %%T', self.tabnr, self.filename)
  end,
  hl = hl.ActiveFile,
}

local WinModified = {
  condition = function(self)
    return self.modified
  end,
  provider = function(self)
    return string.format('%%%dT%s %%T', self.tabnr, icons.small_circle)
  end,
  hl = hl.ModeColors.modified,
}

local TabpageClose = {
  condition = function(self)
    return not self.modified
  end,
  provider = function(self)
    return string.format('%%%dX%s %%X', self.tabnr, icons.cross)
  end,
  hl = hl.Tabpage,
}

local TabPage = {
  init = function(self)
    self.modified = false
    local buflist = vim.fn.tabpagebuflist(self.tabnr)
    for _, v in ipairs(buflist) do
      if vim.bo[v].modified then
        self.modified = true
        break
      end
    end
    self.win_count = 0
    for _, v in ipairs(buflist) do
      if vim.bo[v].buflisted then
        self.win_count = self.win_count + 1
      end
    end
    local winnr = vim.fn.tabpagewinnr(self.tabnr)
    local f = vim.fn.bufname(buflist[winnr])
    local filename = f ~= '' and vim.fn.fnamemodify(f, ':t') or '[No File]'
    self.filename = filename
  end,
  VerticalLine,
  WinCount,
  TabNumber,
  ActiveFile,
  WinModified,
  TabpageClose,
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() > 1
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
