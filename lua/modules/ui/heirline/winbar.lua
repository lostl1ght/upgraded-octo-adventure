local colors = require('modules.ui.heirline.colors')
local conditions = require('heirline.conditions')
local navic = require('nvim-navic')

local Space = setmetatable({ provider = ' ' }, {
  __call = function(_, n)
    return { provider = string.rep(' ', n) }
  end,
})

local Navic = {
  condition = navic.is_available,
  provider = navic.get_location,
  hl = colors.Navic,
}

local winbar = {
  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
        filetype = { '^git.*', 'fugitive' },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  {
    Space,
    Navic,
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'HeirlineInitWinbar',
  callback = function(args)
    local buf = args.buf
    local buftype = vim.tbl_contains({ 'prompt', 'nofile', 'help', 'quickfix' }, vim.bo[buf].buftype)
    local filetype = vim.tbl_contains({ 'gitcommit', 'fugitive' }, vim.bo[buf].filetype)
    if buftype or filetype then
      vim.opt_local.winbar = nil
    end
  end,
})

return { WinBar = winbar }
