local plugin = require('core.lazy').register_plugin
local conf = require('modules.navigation.config')

-- Navitaion
plugin({ 'ggandor/leap.nvim', lazy = false, config = conf.leap })

plugin({
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    --    {
    --      'nvim-telescope/telescope-fzf-native.nvim',
    --      build = function()
    --        vim.fn.system('make')
    --      end,
    --    },
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  config = conf.telescope,
})

plugin({
  'tamago324/lir.nvim',
  dependencies = { 'tamago324/lir-git-status.nvim' },
  config = conf.lir,
})

plugin({ 'sindrets/winshift.nvim', config = conf.winshift, cmd = 'WinShift' })

plugin({ 'toppair/reach.nvim', lazy = false, config = conf.reach })

plugin({ 'aserowy/tmux.nvim', lazy = false, config = conf.tmux })
