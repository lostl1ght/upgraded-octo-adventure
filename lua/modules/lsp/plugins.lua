local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'neovim/nvim-lspconfig', config = conf.lspconfig })

plugin({ 'glepnir/lspsaga.nvim', branch = 'main', config = conf.lspsaga })

plugin({ 'j-hui/fidget.nvim', config = conf.fidget })
