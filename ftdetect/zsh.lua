vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.zsh', '.zshrc', '.zshenv' },
  callback = function()
    vim.opt_local.filetype = 'bash'
  end,
})
