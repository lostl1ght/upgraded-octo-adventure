-- stylua: ignore
local hl_groups = {
  { 'MatchParen', { bold = true, underline = true } },
  {
    'YankHighlight',
    {
      fg = 14460257, -- #dca561
      bg = 4801596,  -- #49443c
    },
  },
  { 'MiniIndentscopeSymbol', { fg = 2969447 } }, -- #2d4f67
  { 'FoldColumn', { fg = 3552838 } },            -- #363646
  { 'LightBulbVirtualText', { fg = 14460257 } }, -- #dca561
  { 'LirFloatBorder', { link = 'FloatermBorder' } },
}
for _, v in ipairs(hl_groups) do
  vim.api.nvim_set_hl(0, unpack(v))
end

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
end
