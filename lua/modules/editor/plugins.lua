local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin({ 'lewis6991/impatient.nvim' })

plugin({ 'nvim-treesitter/nvim-treesitter', config = conf.treesitter })

plugin({ 'antoinemadec/FixCursorHold.nvim' }) -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

plugin({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  tag = 'nightly',
  config = conf.nvimtree,
})
