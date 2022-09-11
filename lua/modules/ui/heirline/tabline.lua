local hl = require('modules.ui.heirline.colors')
local utils = require('heirline.utils')

local TabNumber = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = hl.Tabpage,
}

local TabPage = {
  TabNumber,
}

local TabpageClose = {
  provider = '%999X  %X',
  hl = hl.TabpageClose,
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = '%=' },
  utils.make_tablist(TabPage),
  TabpageClose,
  { provider = '%=' },
}

local tabline = {
  init = function()
    vim.o.showtabline = 1
  end,
  TabPages,
}

return { TabLine = tabline }
