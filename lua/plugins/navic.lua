local M = { 'SmiteshP/nvim-navic' }

M.config = function()
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
    { 'NavicIconsFile', { link = '@text.uri' } },
    { 'NavicIconsModule', { link = '@namespace' } },
    { 'NavicIconsNamespace', { link = '@namespace' } },
    { 'NavicIconsPackage', { link = '@namespace' } },
    { 'NavicIconsClass', { link = '@type' } },
    { 'NavicIconsMethod', { link = '@method' } },
    { 'NavicIconsProperty', { link = '@method' } },
    { 'NavicIconsField', { link = '@field' } },
    { 'NavicIconsConstructor', { link = '@constructor' } },
    { 'NavicIconsEnum', { link = '@type' } },
    { 'NavicIconsInterface', { link = '@type' } },
    { 'NavicIconsFunction', { link = '@function' } },
    { 'NavicIconsVariable', { link = '@constant' } },
    { 'NavicIconsConstant', { link = '@constant' } },
    { 'NavicIconsString', { link = '@string' } },
    { 'NavicIconsNumber', { link = '@number' } },
    { 'NavicIconsBoolean', { link = '@boolean' } },
    { 'NavicIconsArray', { link = '@constant' } },
    { 'NavicIconsObject', { link = '@type' } },
    { 'NavicIconsKey', { link = '@type' } },
    { 'NavicIconsNull', { link = '@type' } },
    { 'NavicIconsEnumMember', { link = '@field' } },
    { 'NavicIconsStruct', { link = '@type' } },
    { 'NavicIconsEvent', { link = '@type' } },
    { 'NavicIconsOperator', { link = '@operator' } },
    { 'NavicIconsTypeParameter', { link = '@parameter' } },
    { 'NavicSeparator', { link = 'Comment' } },
  }
  for _, v in ipairs(groups) do
    vim.api.nvim_set_hl(0, unpack(v))
  end
end

return M
