local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  tag = 'nightly',
  config = conf.nvimtree,
  cmd = 'NvimTreeToggle',
})

plugin({ 'nvim-telescope/telescope.nvim', cmd = 'Telescope', config = conf.telescope })

plugin({ 'numToStr/Comment.nvim', config = conf.comment })

plugin({ 'rmagatti/auto-session', config = conf.autosession })

plugin({ 'szw/vim-maximizer' })

plugin({ 'mrjones2014/smart-splits.nvim', requires = 'kwkarlwang/bufresize.nvim', config = conf.smart_splits })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift })

plugin({ 'Akianonymus/nvim-colorizer.lua', config = conf.colorizer })

plugin({ 'marklcrns/vim-smartq' })

plugin({ '~/dev/plugins/langmap_switch.nvim', config = conf.langmap_switch })
