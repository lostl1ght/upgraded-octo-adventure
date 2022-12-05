local plugin = require('core.packer').register_plugin
local conf = require('modules.git.config')

plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns })

plugin({ 'tpope/vim-fugitive' })
