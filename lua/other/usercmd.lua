vim.api.nvim_create_user_command('DapHydra', function()
  require('modules.ui.hydra').dap:activate()
end, { nargs = 0 })
