local config = {}

function config.kanagawa()
  local colors = require('kanagawa.colors').setup()
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      NeogitHunkHeader = { bg = colors.diff.text },
      NeogitHunkHeaderHighlight = { fg = colors.git.changed, bg = colors.diff.text },
      NeogitDiffContextHighlight = { bg = colors.diff.change },
      NeogitDiffDeleteHighlight = { fg = colors.git.removed, bg = colors.diff.delete },
      NeogitDiffAddHighlight = { fg = colors.git.added, bg = colors.diff.add },
    },
  })
  vim.cmd('colorscheme kanagawa')
end

function config.heirline()
  local statuline = require('modules.ui.heirline.statusline').StatusLine
  local winbar = require('modules.ui.heirline.winbar').WinBar
  local tabline = require('modules.ui.heirline.tabline').TabLine
  require('heirline').setup(statuline, winbar, tabline)
end

function config.dressing()
  require('dressing').setup({
    input = {
      relative = 'editor',
    },
  })
end

function config.fidget()
  require('fidget').setup({
    window = {
      relative = 'editor',
    },
  })
end

function config.navic()
  require('nvim-navic').setup({
    icons = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
    highlight = true,
  })
  local groups = {
    { group = 'NavicIconsFile', link = 'TSURI' },
    { group = 'NavicIconsModule', link = 'TSNamespace' },
    { group = 'NavicIconsNamespace', link = 'TSNamespace' },
    { group = 'NavicIconsPackage', link = 'TSNamespace' },
    { group = 'NavicIconsClass', link = 'TSType' },
    { group = 'NavicIconsMethod', link = 'TSMethod' },
    { group = 'NavicIconsProperty', link = 'TSMethod' },
    { group = 'NavicIconsField', link = 'TSField' },
    { group = 'NavicIconsConstructor', link = 'TSConstructor' },
    { group = 'NavicIconsEnum', link = 'TSType' },
    { group = 'NavicIconsInterface', link = 'TSType' },
    { group = 'NavicIconsFunction', link = 'TSFunction' },
    { group = 'NavicIconsVariable', link = 'TSConstant' },
    { group = 'NavicIconsConstant', link = 'TSConstant' },
    { group = 'NavicIconsString', link = 'TSString' },
    { group = 'NavicIconsNumber', link = 'TSNumber' },
    { group = 'NavicIconsBoolean', link = 'TSBoolean' },
    { group = 'NavicIconsArray', link = 'TSConstant' },
    { group = 'NavicIconsObject', link = 'TSType' },
    { group = 'NavicIconsKey', link = 'TSType' },
    { group = 'NavicIconsNull', link = 'TSType' },
    { group = 'NavicIconsEnumMember', link = 'TSField' },
    { group = 'NavicIconsStruct', link = 'TSType' },
    { group = 'NavicIconsEvent', link = 'TSType' },
    { group = 'NavicIconsOperator', link = 'TSOperator' },
    { group = 'NavicIconsTypeParameter', link = 'TSParameter' },
    { group = 'NavicSeparator', link = 'Comment' },
  }
  for _, v in ipairs(groups) do
    vim.api.nvim_set_hl(0, v.group, { link = v.link })
  end
end

return config
