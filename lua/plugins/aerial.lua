local M = { 'stevearc/aerial.nvim' }

M.cmd = 'AerialToggle'

M.config = function()
  require('aerial').setup({
    backends = { 'lsp', 'treesitter' },
    filter_kind = false,
  })
end

return M
