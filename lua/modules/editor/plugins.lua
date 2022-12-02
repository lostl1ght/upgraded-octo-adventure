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

-- Navitaion
plugin({ 'ggandor/leap.nvim', config = conf.leap })

plugin({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  config = conf.telescope,
})

plugin({ 'tamago324/lir.nvim', requires = 'tamago324/lir-git-status.nvim', config = conf.lir })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift, cmd = 'WinShift' })

plugin({ 'toppair/reach.nvim', config = conf.reach })

plugin({ 'aserowy/tmux.nvim', config = conf.tmux })

-- Other tools
plugin({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })

plugin({
  'iamcco/markdown-preview.nvim',
  run = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = 'markdown',
})

plugin({
  'folke/persistence.nvim',
  event = 'BufReadPre',
  module = 'persistence',
  config = conf.persistence,
})

plugin({ 'NvChad/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })
