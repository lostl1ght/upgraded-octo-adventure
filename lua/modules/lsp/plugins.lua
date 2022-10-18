local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'stevearc/aerial.nvim', module = 'aerial', config = conf.aerial })

plugin({ 'folke/neodev.nvim', ft = 'lua', config = conf.luadev })

plugin({ 'neovim/nvim-lspconfig', ft = { 'lua', 'rust', 'c', 'cpp' }, config = conf.lspconfig })

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
