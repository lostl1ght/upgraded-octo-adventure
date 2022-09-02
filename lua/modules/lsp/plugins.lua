local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'neovim/nvim-lspconfig', config = conf.lspconfig })

plugin({ 'glepnir/lspsaga.nvim', branch = 'main', config = conf.lspsaga })

plugin({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim', config = conf.null_ls })

plugin({ 'simrat39/symbols-outline.nvim', config = conf.outline })

plugin({ 'folke/trouble.nvim', config = conf.trouble })

plugin({ 'ray-x/lsp_signature.nvim', config = conf.signature })

plugin({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", after = 'nvim-lspconfig', config = conf.lsplines, })
