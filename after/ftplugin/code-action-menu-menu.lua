local group = vim.api.nvim_create_augroup('CustomCodeActionGroup', {})
vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeActionMenuWindowOpened',
  group = group,
  once = true,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
