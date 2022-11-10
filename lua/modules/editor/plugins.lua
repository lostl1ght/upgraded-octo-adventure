local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

-- Plenary
plugin({ 'nvim-lua/plenary.nvim' })

-- Treesitter
plugin({
  'nvim-treesitter/nvim-treesitter',
  requires = 'IndianBoy42/tree-sitter-just',
  config = conf.treesitter,
})

-- Editing
plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

plugin({ 'kylechui/nvim-surround', config = conf.surround })

plugin({
  'abecodes/tabout.nvim',
  require = 'nvim-treesitter',
  after = 'nvim-cmp',
  config = conf.tabout,
})

plugin({ 'numToStr/Comment.nvim', config = conf.comment })

plugin({ 'echasnovski/mini.ai', config = conf.ai })

-- Navitaion
plugin({ 'ggandor/lightspeed.nvim' })

plugin({
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  config = conf.telescope,
})

plugin({ '~/dev/plugins/nvim-lf', config = conf.lf })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift, cmd = 'WinShift' })

plugin({ 'ghillb/cybu.nvim', config = conf.cybu })

plugin({ 'aserowy/tmux.nvim', config = conf.tmux })

-- Other tools
plugin({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })

plugin({
  'folke/persistence.nvim',
  event = 'BufReadPre',
  module = 'persistence',
  config = conf.persistence,
})

plugin({ 'NvChad/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })

plugin({
  'toppair/peek.nvim',
  run = 'deno task --quiet build:fast',
  config = conf.peek,
  module = 'peek',
})
