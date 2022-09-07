local plugin = require('core.pack').register_plugin
local conf = require('modules.git.config')

plugin({
  'TimUntersberger/neogit',
  requires = 'nvim-lua/plenary.nvim',
  after = 'diffview.nvim',
  config = conf.neogit,
})

plugin({ 'sindrets/diffview.nvim', config = conf.diffview, cmd = 'Neogit' })

plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns })
