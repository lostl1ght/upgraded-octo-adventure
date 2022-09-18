local config = {}

function config.gitsigns()
  require('gitsigns').setup()
end

function config.lazygit()
  vim.api.nvim_set_hl(0, 'LazyGitNormal', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'LazyGitBorder', { link = 'FloatermBorder' })
  require('lazygit').setup()
end

return config
