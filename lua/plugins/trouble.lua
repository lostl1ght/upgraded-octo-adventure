local M = { 'folke/trouble.nvim' }

M.cmd = 'Trouble'

M.dependencies = { 'neovim/nvim-lspconfig', 'nvim-tree/nvim-web-devicons' }
M.config = function()
  require('trouble').setup({
    position = 'top',
  })
end

return M
