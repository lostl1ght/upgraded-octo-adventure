local config = {}

function config.dap()
  local dap = require('dap')
  local dir = vim.fn.stdpath('data') .. '/codelldb/extension/'
  local cmd = dir .. 'adapter/codelldb'
  local lib = dir .. 'lldb/lib/liblldb.so'
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = cmd,
      args = { '--liblldb', lib, '--port', '${port}' },
    },
  }
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
  }

  -- must be the last
  vim.fn.sign_define('DapBreakpoint', { text = '⏺ ', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '⏺ ', texthl = 'ModeMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '⮕ ', texthl = 'Directory', linehl = '', numhl = '' })
end

function config.dapui()
  local dap, dapui = require('dap'), require('dapui')
  dapui.setup()
  dap.listeners.after.event_initialized['dapui_config'] = function()
    vim.bo.modifiable = false
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    vim.bo.modifiable = true
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    vim.bo.modifiable = true
    dapui.close()
  end
  vim.api.nvim_create_user_command('DapEval', function()
    dapui.eval()
  end, { nargs = 0 })
end

function config.dapjson()
  require('dap-json').setup({})
end

return config
