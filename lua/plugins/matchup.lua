local M = { 'andymass/vim-matchup' }

M.event = 'BufReadPre'

M.dependencies = { 'nvim-treesitter/nvim-treesitter' }

M.config = function()
  vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  require('nvim-treesitter.configs').setup({
    matchup = {
      enable = true,
      include_match_words = true,
    },
  })
end

return M
