local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin({ 'lewis6991/impatient.nvim' })

plugin({ 'nvim-treesitter/nvim-treesitter', config = conf.treesitter})
