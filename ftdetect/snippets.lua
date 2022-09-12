vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.snippets',
  callback = function()
    vim.opt_local.filetype = 'snippets'
  end,
})
