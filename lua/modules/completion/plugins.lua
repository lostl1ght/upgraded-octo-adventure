local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({ 'L3MON4D3/LuaSnip', config = conf.luasnip, module = 'luasnip' })

plugin({
  'hrsh7th/nvim-cmp',
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', module = 'cmp_buffer' },
    { 'onsails/lspkind.nvim', module = 'lspkind' },
  },
  event = { 'InsertEnter', 'CmdLineEnter' },
  module = 'cmp',
  config = conf.cmp,
})
