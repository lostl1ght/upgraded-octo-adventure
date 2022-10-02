local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.null_ls,
  event = 'LspAttach',
})

plugin({ 'folke/trouble.nvim', event = 'LspAttach', config = conf.trouble })

plugin({ 'ray-x/lsp_signature.nvim', event = 'LspAttach', config = conf.signature })

plugin({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'LspAttach',
  config = conf.lsplines,
})

plugin({
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  config = conf.lightbulb,
})

plugin({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', config = conf.codeaction })

plugin({ 'folke/lua-dev.nvim', ft = 'lua' })

plugin({ 'stevearc/aerial.nvim', config = conf.aerial })
