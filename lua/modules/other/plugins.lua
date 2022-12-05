local plugin = require('core.packer').register_plugin
local conf = require('modules.other.config')

-- Other tools
plugin({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })

plugin({
  'iamcco/markdown-preview.nvim',
  run = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = 'markdown',
})

plugin({
  'folke/persistence.nvim',
  event = 'BufReadPre',
  module = 'persistence',
  config = conf.persistence,
})

plugin({ 'NvChad/nvim-colorizer.lua', config = conf.colorizer, cmd = 'ColorizerToggle' })
