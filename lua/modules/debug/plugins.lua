local plugin = require('core.pack').register_plugin
local conf = require('modules.debug.config')

plugin({ 'mfussenegger/nvim-dap', config = conf.dap })

plugin({ 'rcarriga/nvim-dap-ui', requires = 'mfussenegger/nvim-dap', config = conf.dapui })