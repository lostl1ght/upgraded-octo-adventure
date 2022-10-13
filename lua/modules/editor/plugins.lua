local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin({ 'nvim-lua/plenary.nvim' })

plugin({ 'nvim-treesitter/nvim-treesitter', config = conf.treesitter })

plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

plugin({ 'abecodes/tabout.nvim', require = 'nvim-treesitter', after = 'nvim-cmp', config = conf.tabout })

plugin({ 'kylechui/nvim-surround', config = conf.surround })

plugin({ 'tversteeg/registers.nvim', config = conf.registers })

plugin({ 'ggandor/lightspeed.nvim' })

plugin({ 'famiu/bufdelete.nvim' })
