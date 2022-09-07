local plugin = require('core.pack').register_plugin
local conf = require('modules.debug.config')

plugin({
  'mfussenegger/nvim-dap',
  cmd = {
    'DapContinue',
    'DapTerminate',
    'DapToggleBreakpoint',
    'DapStepOver',
    'DapStepInto',
    'DapStepOut',
    'DapEval',
    'DapRun',
  },
  config = conf.dap,
})

plugin({ 'rcarriga/nvim-dap-ui', requires = 'mfussenegger/nvim-dap', config = conf.dapui, after = 'nvim-dap' })

plugin({ 'lostl1ght/dap-json.nvim', requires = 'mfussenegger/nvim-dap', config = conf.dapjson, after = 'nvim-dap' })
