local plugin = require('core.lazy').register_plugin
local conf = require('modules.lsp.config')

plugin({ 'stevearc/aerial.nvim', cmd = 'AerialToggle', config = conf.aerial })

local ft = {
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
}
plugin({
  'neovim/nvim-lspconfig',
  dependencies = { { 'folke/neodev.nvim' } },
  config = conf.lspconfig,
})

plugin({ 'jose-elias-alvarez/null-ls.nvim', lazy = false, config = conf.null_ls })

plugin({
  'folke/trouble.nvim',
  config = conf.trouble,
  cmd = 'Trouble',
  dependencies = { 'neovim/nvim-lspconfig' },
})

plugin({
  url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = conf.lsplines,
  ft = ft,
  dependencies = { 'neovim/nvim-lspconfig' },
})

plugin({
  'kosayoda/nvim-lightbulb',
  config = conf.lightbulb,
  ft = ft,
  dependencies = { 'neovim/nvim-lspconfig' },
})

plugin({
  'weilbith/nvim-code-action-menu',
  cmd = 'CodeActionMenu',
  config = conf.codeaction,
})

plugin({
  'dnlhc/glance.nvim',
  config = conf.glance,
  cmd = 'Glance',
  dependencies = { 'neovim/nvim-lspconfig' },
})

plugin({ 'SmiteshP/nvim-navic', config = conf.navic })
