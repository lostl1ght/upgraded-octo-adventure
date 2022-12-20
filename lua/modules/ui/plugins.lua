local plugin = require('core.lazy').register_plugin
local conf = require('modules.ui.config')

plugin({ 'rebelot/kanagawa.nvim', lazy = false, config = conf.kanagawa })

plugin({
  'rebelot/heirline.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'nvim-langmap-switch', dev = true },
    'folke/noice.nvim',
    'SmiteshP/nvim-navic',
  },
  config = conf.heirline,
})

plugin({ 'stevearc/dressing.nvim', event = 'VeryLazy', config = conf.dressing })

plugin({ 'RRethy/vim-illuminate', event = 'VeryLazy', config = conf.illum })

plugin({
  'andymass/vim-matchup',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = conf.matchup,
})

plugin({
  'nvim-langmap-switch',
  event = 'VeryLazy',
  dev = true,
  config = conf.langmap_switch,
})

plugin({
  'folke/noice.nvim',
  config = conf.noice,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
})

plugin({
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  config = conf.indentscope,
})

plugin({ 'folke/which-key.nvim', event = 'VeryLazy', config = conf.whichkey })
