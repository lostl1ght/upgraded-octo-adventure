local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'neovim/nvim-lspconfig', ft = { 'lua', 'rust', 'haskell' }, config = conf.lspconfig })

plugin({ 'glepnir/lspsaga.nvim', cmd = 'Lspsaga', branch = 'main', config = conf.lspsaga })

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  after = 'nvim-lspconfig',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.null_ls,
})

plugin({ 'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline', config = conf.outline })

plugin({ 'folke/trouble.nvim', cmd = 'TroubleToggle', config = conf.trouble })

plugin({ 'ray-x/lsp_signature.nvim', after = 'nvim-lspconfig', config = conf.signature })

plugin({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  after = 'nvim-lspconfig',
  config = conf.lsplines,
})
