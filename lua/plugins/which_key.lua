local M = { 'folke/which-key.nvim' }

M.event = 'VeryLazy'

M.config = function()
  local wk = require('which-key')
  wk.setup({
    show_help = false,
    show_keys = false,
    triggers_blacklist = {
      i = { 'j', 'k', 'i' },
      v = { 'j', 'k', 'i' },
    },
  })
  wk.register({
    ['<leader>'] = {
      w = { name = 'window' },
      g = { name = 'git' },
      t = { name = 'telescope' },
      d = { name = 'debug' },
      q = { name = 'persistence' },
      l = { name = 'lsp' },
    },
  }, {})
end

return M
