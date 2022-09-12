vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.json',
  callback = function()
    vim.opt_local.filetype = 'jsonc'
  end,
})
