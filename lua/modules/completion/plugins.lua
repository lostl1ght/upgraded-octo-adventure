local plugin = require('core.lazy').register_plugin
local conf = require('modules.completion.config')

plugin({ 'L3MON4D3/LuaSnip', config = conf.luasnip })

plugin({
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-buffer' },
    { 'onsails/lspkind.nvim' },
  },
  event = { 'InsertEnter', 'CmdLineEnter' },
  config = conf.cmp,
})
