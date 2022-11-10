local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa })

plugin({
  'rebelot/heirline.nvim',
  requires = {
    'nvim-tree/nvim-web-devicons',
    'nvim-langmap-switch',
    'folke/noice.nvim',
  },
  after = { 'nvim-langmap-switch' },
  config = conf.heirline,
})

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })

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

plugin({
  'echasnovski/mini.indentscope',
  config = conf.indentscope,
})

plugin({ 'folke/which-key.nvim', config = conf.whichkey })
