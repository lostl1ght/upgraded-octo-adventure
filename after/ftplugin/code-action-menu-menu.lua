vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeActionMenuWindowOpened',
  group = vim.api.nvim_create_augroup('CustomCodeActionGroup', {}),
  once = true,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
