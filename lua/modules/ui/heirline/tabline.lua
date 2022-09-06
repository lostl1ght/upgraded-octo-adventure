local hl = require('modules.ui.heirline.colors')
local icons = require('modules.ui.heirline.icons').icons

local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. '. '
  end,
  hl = hl.TablineBufnr,
}

local Space = setmetatable({ provider = ' ' }, {
  __call = function(_, n)
    return { provider = string.rep(' ', n) }
  end,
})

local os_sep = package.config:sub(1, 1)
local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == '' and '[No Name]'
      or string.format('%s%s%s', vim.fn.fnamemodify(filename, ':p:h:t'), os_sep, vim.fn.fnamemodify(filename, ':t'))
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local TablineFileFlags = {
  {
    provider = function(self)
      if vim.bo[self.bufnr].modified then
        return icons.small_circle
      end
    end,
    hl = hl.TablineFileFlags.modified,
  },
  {
    provider = function(self)
      if not vim.bo[self.bufnr].modifiable or vim.bo[self.bufnr].readonly then
        return icons.padlock
      end
    end,
    hl = hl.TablineFileFlags.readonly,
  },
}

local devicons = require('nvim-web-devicons')
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

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = hl.TablineFileNameBlock,
  on_click = {
    callback = function(_, minwid)
      vim.api.nvim_win_set_buf(0, minwid)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = 'heirline_tabline_buffer_callback',
  },
  Space,
  TablineBufnr,
  FileIcon,
  Space,
  TablineFileName,
  Space,
  TablineFileFlags,
}

local TablineCloseButton = {
  condition = function(self)
    return not vim.bo[self.bufnr].modified
  end,
  {
    provider = icons.close,
    hl = hl.TablineCloseButton,
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_buf_delete(minwid, { force = false })
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}
local utils = require('heirline.utils')

local TablineBufferBlock = {
  hl = hl.TablineBufferBlock,
  TablineFileNameBlock,
  TablineCloseButton,
  Space,
}

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = icons.bufferline.left, hl = hl.BufferLine },
  { provider = icons.bufferline.right, hl = hl.BufferLine }
)

local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = hl.Tabpage,
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
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == 'NvimTree' then
      self.title = 'NvimTree'
      return true
      -- elseif vim.bo[bufnr].filetype == "TagBar" then
      --     ...
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(' ', pad) .. title .. string.rep(' ', pad)
  end,

  hl = hl.TabLineOffset,
}

local tabline = { TabLineOffset, BufferLine, TabPages }

return { TabLine = tabline }
