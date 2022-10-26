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

plugin({ 'anuvyklack/hydra.nvim', config = conf.hydra })

plugin({ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = conf.ufo })

plugin({ 'RRethy/vim-illuminate', config = conf.illum })

plugin({
  'andymass/vim-matchup',
  requires = 'nvim-treesitter',
  after = 'nvim-treesitter',
  config = conf.matchup,
})

plugin({ '~/dev/plugins/nvim-langmap-switch', config = conf.langmap_switch })

plugin({
  'folke/noice.nvim',
  config = conf.noice,
  requires = {
    'MunifTanjim/nui.nvim',
  },
})
