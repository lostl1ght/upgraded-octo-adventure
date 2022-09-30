local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({
  'neovim/nvim-lspconfig',
  ft = { 'lua', 'rust', 'tex', 'bib', 'python', 'go', 'c', 'cpp' },
  config = conf.lspconfig,
})

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  after = 'nvim-lspconfig',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.null_ls,
})

plugin({ 'folke/trouble.nvim', cmd = 'TroubleToggle', config = conf.trouble })

plugin({ 'ray-x/lsp_signature.nvim', after = 'nvim-lspconfig', config = conf.signature })

plugin({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  after = 'nvim-lspconfig',
  config = conf.lsplines,
})

plugin({
  'kosayoda/nvim-lightbulb',
  after = 'nvim-lspconfig',
  config = conf.lightbulb,
})

plugin({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', config = conf.codeaction })

plugin({ 'folke/lua-dev.nvim', ft = 'lua' })

plugin({ 'stevearc/aerial.nvim', config = conf.aerial })
