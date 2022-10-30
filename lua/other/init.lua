require('other.autocmd')
require('other.usercmd')
require('other.filetype')

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local hl = vim.api.nvim_set_hl
hl(0, 'MatchParen', { bold = true, underline = true })
