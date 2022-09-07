local plugin = require('core.pack').register_plugin
local conf = require('modules.git.config')
local setup = require('modules.git.setup')

plugin({
  'TimUntersberger/neogit',
  requires = 'nvim-lua/plenary.nvim',
  setup = setup.neogit,
  after = 'diffview.nvim',
})

plugin({ 'sindrets/diffview.nvim', config = conf.diffview, cmd = 'Neogit' })

plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns })
