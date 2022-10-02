local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
}

vim.schedule(function()
  vim.lsp.start({
    name = 'rust-analyzer',
    cmd = { 'rust-analyzer' },
    root_dir = vim.fs.dirname(vim.fs.find({
      'Cargo.toml',
      'rust-project.json',
    }, { upward = true })[1]),
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
    handlers = handlers,
    on_attach = require('aerial').on_attach,
  })
end)

if not vim.g.rust_analyzer_cmds then
  vim.g.rust_analyzer_cmds = true
  vim.schedule(function()
    vim.api.nvim_create_user_command('CargoReload', function()
      vim.lsp.buf_request(0, 'rust-analyzer/reloadWorkspace', nil, function(err)
        if err then
          error(tostring(err))
        end
        vim.notify('Cargo workspace reloaded')
      end)
    end, { nargs = 0 })
  end)
end
