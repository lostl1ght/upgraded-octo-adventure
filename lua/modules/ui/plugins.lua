local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa })

plugin({
  'rebelot/heirline.nvim',
  requires = {
    'kyazdani42/nvim-web-devicons',
    'kanagawa.nvim',
    'langmap_switch.nvim',
  },
  after = { 'kanagawa.nvim', 'langmap_switch.nvim' },
  config = conf.heirline,
})

plugin({ 'anuvyklack/hydra.nvim' })

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })

plugin({ 'j-hui/fidget.nvim', config = conf.fidget })
