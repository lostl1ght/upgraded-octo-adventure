local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({
  'hrsh7th/nvim-cmp',
  requires = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = conf.cmp,
})

plugin({ 'L3MON4D3/LuaSnip', config = conf.luasnip })
