local M = {
  'iamcco/markdown-preview.nvim',
}

M.ft = 'markdown'

M.build = vim.fn['mkdp#util#install']

return M
