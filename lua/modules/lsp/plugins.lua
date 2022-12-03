local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'stevearc/aerial.nvim', cmd = 'AerialToggle', config = conf.aerial })

plugin({
  'neovim/nvim-lspconfig',
  requires = { 'folke/neodev.nvim', module = 'neodev' },
  ft = {
    'bib',
    'c',
    'cpp',
    'css',
    'html',
    'htmldjango',
    'lua',
    'python',
    'rust',
    'tex',
  },
  config = conf.lspconfig,
})

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.null_ls,
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

plugin({ 'dnlhc/glance.nvim', config = conf.glance, after = 'nvim-lspconfig' })
