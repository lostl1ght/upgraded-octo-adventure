local cmds = {
  {
    'DapHydra',
    function()
      require('modules.ui.hydra').dap:activate()
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
  {
    'LspFormat',
    function(args)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == 'null-ls' or client.name == 'clangd'
        end,
        bufnr = args.args ~= '' and tonumber(args.args) or 0,
      })
      vim.cmd('silent w')
    end,
    { nargs = '?' },
  },
  {
    'LspInfo',
    function()
      for _, client in ipairs(vim.lsp.get_active_clients({})) do
        print(client.name)
      end
    end,
    { nargs = 0 },
  },
}

for _, v in ipairs(cmds) do
  vim.api.nvim_create_user_command(unpack(v))
end
