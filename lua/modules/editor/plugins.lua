local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin({ 'nvim-lua/plenary.nvim' })

plugin({ 'nvim-treesitter/nvim-treesitter', config = conf.treesitter })

plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

-- plugin({ 'abecodes/tabout.nvim', require = 'nvim-treesitter', after = 'nvim-cmp', config = conf.tabout })

plugin({ 'declancm/cinnamon.nvim', config = conf.cinnamon })

plugin({ 'kylechui/nvim-surround', tag = '*', config = conf.surround })

plugin({ 'tversteeg/registers.nvim', config = conf.registers })

plugin({ 'ggandor/lightspeed.nvim' })

plugin({
  'andymass/vim-matchup',
  requires = 'nvim-treesitter',
  after = 'nvim-treesitter',
  config = conf.matchup,
})

plugin({
  'aserowy/tmux.nvim',
  config = conf.tmux,
})

plugin({ 'famiu/bufdelete.nvim' })
