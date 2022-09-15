local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({ 'nvim-telescope/telescope.nvim', cmd = 'Telescope', config = conf.telescope })

plugin({ 'numToStr/Comment.nvim', config = conf.comment })

plugin({ 'rmagatti/auto-session', config = conf.autosession })

plugin({ 'szw/vim-maximizer' })

plugin({
  'mrjones2014/smart-splits.nvim',
  requires = 'kwkarlwang/bufresize.nvim',
  after = 'bufresize.nvim',
  config = conf.smart_splits,
})

plugin({ 'kwkarlwang/bufresize.nvim', config = conf.bufresize })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift })

plugin({ 'Akianonymus/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })

plugin({ '~/dev/plugins/nvim-langmap-switch', config = conf.langmap_switch })

plugin({ 'kevinhwang91/rnvimr', setup = conf.rnvimr, cmd = 'RnvimrToggle' })
