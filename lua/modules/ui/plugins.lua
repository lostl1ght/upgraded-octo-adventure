local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'navarasu/onedark.nvim', config = conf.onedark })

plugin({ 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', config = conf.bufferline })

plugin({ 'rebelot/heirline.nvim', requires = 'kyazdani42/nvim-web-devicons', config = conf.heirline })

plugin({ 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig' })

plugin({ 'anuvyklack/hydra.nvim' })

plugin({ 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' })

plugin({ 'szw/vim-maximizer' })

plugin({ 'mrjones2014/smart-splits.nvim', requires = 'kwkarlwang/bufresize.nvim', config = conf.smart_splits })

plugin({ 'sindrets/winshift.nvim', config = conf.winshift })

plugin({ 'glepnir/dashboard-nvim', config = conf.dashboard })

plugin({ 'vigoux/notifier.nvim', config = conf.notifier })

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })
