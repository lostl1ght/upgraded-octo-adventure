local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  config = conf.telescope,
})

plugin({ 'numToStr/Comment.nvim', config = conf.comment })

plugin({ 'Shatur/neovim-session-manager', config = conf.session })

plugin({
  'mrjones2014/smart-splits.nvim',
  config = conf.smart_splits,
})

plugin({ 'sindrets/winshift.nvim', config = conf.winshift })

plugin({ 'Akianonymus/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })

plugin({ 'IndianBoy42/tree-sitter-just', config = conf.just })

plugin({ '~/dev/plugins/nvim-lf', config = conf.lf })

plugin({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
