local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({ 'onsails/lspkind.nvim', event = { 'InsertEnter', 'CmdLineEnter' } })
plugin({ 'L3MON4D3/LuaSnip', config = conf.luasnip, event = { 'InsertEnter', 'CmdLineEnter' } })

plugin({
  'hrsh7th/nvim-cmp',
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'L3MON4D3/LuaSnip' },
    { 'onsails/lspkind.nvim' },
  },
  after = { 'lspkind.nvim', 'LuaSnip' },
})

plugin({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp', config = conf.cmp })
