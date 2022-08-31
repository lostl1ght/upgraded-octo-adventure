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

plugin({ 'nvim-telescope/telescope.nvim', config = conf.telescope })

plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

plugin({ 'abecodes/tabout.nvim', after = 'nvim-cmp', wants = 'nvim-treesitter', config = conf.tabout })

plugin({ 'karb94/neoscroll.nvim', config = conf.neoscroll })

plugin({ 'kylechui/nvim-surround', tag = '*', config = conf.surround })

plugin({ 'tversteeg/registers.nvim' })
