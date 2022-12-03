local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

-- Plenary
plugin({ 'nvim-lua/plenary.nvim' })

-- Treesitter
plugin({
  'nvim-treesitter/nvim-treesitter',
  requires = { 'IndianBoy42/tree-sitter-just', 'nvim-treesitter/playground' },
  config = conf.treesitter,
})

-- Editing
plugin({ 'tpope/vim-commentary' })

plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

plugin({ 'kylechui/nvim-surround', config = conf.surround })

plugin({
  'abecodes/tabout.nvim',
  require = 'nvim-treesitter',
  after = 'nvim-cmp',
  config = conf.tabout,
})

plugin({ 'echasnovski/mini.ai', config = conf.ai })
