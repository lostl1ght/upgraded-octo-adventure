local plugin = require('core.lazy').register_plugin
local conf = require('modules.debug.config')

local cmd = {
  'DapContinue',
  'DapTerminate',
  'DapToggleBreakpoint',
  'DapStepOver',
  'DapStepInto',
  'DapStepOut',
  'DapEval',
  'DapRun',
}

plugin({
  'mfussenegger/nvim-dap',
  config = conf.dap,
})

plugin({
  'rcarriga/nvim-dap-ui',
  cmd = cmd,
  dependencies = { 'mfussenegger/nvim-dap' },
  config = conf.dapui,
})

plugin({
  'lostl1ght/dap-json.nvim',
  cmd = cmd,
  dependencies = { 'mfussenegger/nvim-dap' },
  config = conf.dapjson,
})
