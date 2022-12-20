local hl = require('plugins.heirline.colors')
local icons = require('plugins.heirline.icons').icons

local Space = setmetatable({
  provider = function(self)
    return self.tablabel({ ' ' })
  end,
}, {
  __call = function(_, n)
    return {
      provider = function(self)
        return self.tablabel({ string.rep(' ', n) })
      end,
    }
  end,
})

local VerticalLine = {
  provider = '│',
  hl = hl.VerticalLine,
  Space,
}

local TabNumber = {
  provider = function(self)
    return self.tablabel({ self.tabnr })
  end,
  hl = hl.TabpageClose,
  Space,
}

local WinCount = {
  condition = function(self)
    return self.win_count > 1
  end,
  provider = function(self)
    return self.tablabel({ '(', self.win_count, ')' })
  end,
  hl = hl.WinCount,
  Space,
}

local ActiveFile = {
  provider = function(self)
    return self.tablabel({ self.filename })
  end,
  hl = hl.ActiveFile,
  Space,
}

local WinModified = {
  condition = function(self)
    return self.modified
  end,
  provider = function(self)
    return self.tablabel({ icons.small_circle })
  end,
  hl = hl.ModeColors.modified,
  Space,
}

local TabpageClose = {
  condition = function(self)
    return not self.modified
  end,
  provider = function(self)
    return string.format('%%%dX%s%%X', self.tabnr, icons.cross)
  end,
  hl = hl.TabpageClose,
  Space,
}

local TabPage = {
  init = function(self)
    self.modified = false
    local buflist = vim.fn.tabpagebuflist(self.tabnr)
    self.win_count = 0
    for _, v in ipairs(buflist) do
      if vim.bo[v].buflisted then
        self.win_count = self.win_count + 1
        if vim.bo[v].modified then
          self.modified = true
        end
      end
    end
    local winnr = vim.fn.tabpagewinnr(self.tabnr)
    local f = vim.fn.bufname(buflist[winnr])
    local filename = f ~= '' and vim.fn.fnamemodify(f, ':t') or '[No File]'
    self.filename = filename

    self.tablabel = function(list, sep)
      return '%' .. self.tabnr .. 'T' .. table.concat(list, sep) .. '%T'
    end
  end,
  VerticalLine,
  TabNumber,
  ActiveFile,
  WinCount,
  WinModified,
  TabpageClose,
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() > 1
  end,
  { provider = '%=' },
  require('heirline.utils').make_tablist(TabPage),
  { provider = '%=' },
}

local tabline = {
  init = function()
    vim.o.showtabline = 1
  end,
  TabPages,
}

return { TabLine = tabline }
