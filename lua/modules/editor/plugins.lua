local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin({ 'lewis6991/impatient.nvim' })

plugin({ 'nvim-lua/plenary.nvim' })

plugin({ 'nvim-treesitter/nvim-treesitter', config = conf.treesitter })

plugin({ 'antoinemadec/FixCursorHold.nvim' }) -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

plugin({ 'windwp/nvim-autopairs', config = conf.autopairs })

plugin({ 'abecodes/tabout.nvim', wants = 'nvim-treesitter', config = conf.tabout })

plugin({ 'karb94/neoscroll.nvim', config = conf.neoscroll })

plugin({ 'kylechui/nvim-surround', tag = '*', config = conf.surround })

plugin({ 'tversteeg/registers.nvim', config = conf.registers })
