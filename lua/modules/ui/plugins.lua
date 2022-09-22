local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa })

plugin({
  'rebelot/heirline.nvim',
  requires = {
    'kyazdani42/nvim-web-devicons',
    'kanagawa.nvim',
    'nvim-langmap-switch',
  },
  after = { 'kanagawa.nvim', 'nvim-langmap-switch' },
  config = conf.heirline,
})

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })

plugin({ 'vigoux/notifier.nvim', config = conf.notifier })

plugin({ 'anuvyklack/hydra.nvim', config = conf.hydra  })
