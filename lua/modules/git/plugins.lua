local plugin = require('core.lazy').register_plugin
local conf = require('modules.git.config')

plugin({ 'lewis6991/gitsigns.nvim', lazy = false, config = conf.gitsigns })

plugin({ 'tpope/vim-fugitive', lazy = false })
