local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa })

plugin({
  'rebelot/heirline.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  after = 'kanagawa.nvim',
  config = conf.heirline,
})

plugin({ 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig', config = conf.navic })

plugin({ 'anuvyklack/hydra.nvim' })

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })

plugin({ 'vigoux/notifier.nvim', config = conf.notifier })
