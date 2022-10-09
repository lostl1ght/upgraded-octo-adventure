local plugin = require('core.pack').register_plugin
local conf = require('modules.git.config')

plugin({ '~/dev/plugins/nvim-lazygit', config = conf.lazygit, cmd = 'Lazygit' })

plugin({ 'lewis6991/gitsigns.nvim', config = conf.gitsigns })
