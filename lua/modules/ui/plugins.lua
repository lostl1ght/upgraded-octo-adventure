local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin({ 'navarasu/onedark.nvim', config = conf.onedark })

plugin({ 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', config = conf.bufferline })

plugin({ 'rebelot/heirline.nvim', requires = 'kyazdani42/nvim-web-devicons', config = conf.heirline })

plugin({ 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig' })

plugin({ 'anuvyklack/hydra.nvim' })

plugin({ 'stevearc/dressing.nvim', config = conf.dressing })
