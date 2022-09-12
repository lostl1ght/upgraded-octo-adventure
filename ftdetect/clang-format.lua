vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.clang-format',
  callback = function()
    vim.opt_local.filetype = 'yaml'
  end,
})
