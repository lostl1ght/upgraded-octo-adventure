local plugin = require('core.pack').register_plugin
local conf = require('modules.git.config')

plugin({
  'TimUntersberger/neogit',
  requires = { 'sindrets/diffview.nvim', 'nvim-lua/plenary.nvim' },
  after = 'kanagawa.nvim',
  config = conf.neogit,
})

plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns })
