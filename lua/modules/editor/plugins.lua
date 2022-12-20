local plugin = require('core.lazy').register_plugin
local conf = require('modules.editor.config')

-- Plenary
plugin({ 'nvim-lua/plenary.nvim', lazy = false, })

-- Treesitter
plugin({ 'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'IndianBoy42/tree-sitter-just', lazy  = false },
  },
  config = conf.treesitter
})

-- Editing
plugin({ 'tpope/vim-commentary', lazy = false, })

plugin({ 'windwp/nvim-autopairs', lazy = false, config = conf.autopairs })

plugin({ 'kylechui/nvim-surround', lazy = false, config = conf.surround })

plugin({ 'abecodes/tabout.nvim', lazy = false,config = conf.tabout })

plugin({ 'echasnovski/mini.ai', lazy = false, config = conf.ai })
