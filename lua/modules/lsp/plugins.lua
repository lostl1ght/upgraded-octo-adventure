local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'stevearc/aerial.nvim', module = 'aerial', config = conf.aerial })

plugin({ 'folke/neodev.nvim', ft = 'lua', config = conf.luadev })

plugin({ 'neovim/nvim-lspconfig', ft = { 'lua', 'rust', 'c', 'cpp', 'python' }, config = conf.lspconfig })

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.null_ls,
  after = 'nvim-lspconfig',
})

plugin({
  'ray-x/lsp_signature.nvim',
  config = conf.signature,
  after = 'nvim-lspconfig',
})

plugin({
  'folke/trouble.nvim',
  config = conf.trouble,
  after = 'nvim-lspconfig',
})

plugin({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = conf.lsplines,
  after = 'nvim-lspconfig',
})

plugin({
  'kosayoda/nvim-lightbulb',
  config = conf.lightbulb,
  after = 'nvim-lspconfig',
})

plugin({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', config = conf.codeaction })
