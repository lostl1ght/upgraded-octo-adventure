local cmds = {
  {
    'DapHydra',
    function()
      require('modules.ui.hydra').debug:activate()
    end,
    { nargs = 0 },
  },
  {
    'SessionHydra',
    function()
      require('modules.ui.hydra').session:activate()
    end,
    { nargs = 0 },
  },
}

for _, v in ipairs(cmds) do
  vim.api.nvim_create_user_command(unpack(v))
end
