local plugin = require('core.packer').register_plugin
local conf = require('modules.navigation.config')

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
