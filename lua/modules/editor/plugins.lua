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

plugin({ 'tversteeg/registers.nvim', config = conf.registers })

plugin({
  'abecodes/tabout.nvim',
  require = 'nvim-treesitter',
  after = 'nvim-cmp',
  config = conf.tabout,
})

plugin({ 'numToStr/Comment.nvim', config = conf.comment })

-- Navitaion
plugin({ 'ggandor/lightspeed.nvim' })

plugin({
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  config = conf.telescope,
})

plugin({ '~/dev/plugins/nvim-lf', config = conf.lf })

plugin({ 'mrjones2014/smart-splits.nvim', config = conf.smart_splits, module = 'smart-splits' })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift, cmd = 'WinShift' })

plugin({ 'ghillb/cybu.nvim', config = conf.cybu })

-- Other tools
plugin({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })

plugin({ 'Shatur/neovim-session-manager', config = conf.session })

plugin({ 'NvChad/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })

plugin({
  'toppair/peek.nvim',
  run = 'deno task --quiet build:fast',
  config = conf.peek,
  module = 'peek',
})
