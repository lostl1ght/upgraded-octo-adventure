local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
}

vim.schedule(function()
  vim.lsp.start({
    name = 'clangd',
    cmd = { 'clangd' },
    root_dir = vim.fs.dirname(vim.fs.find({
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      '.git',
    }, { upward = true })[1]),
    handlers = handlers,
    on_attach = require('aerial').on_attach,
  })
end)

if not vim.g.clangd_cmds then
  vim.g.clangd_cmds = true
  vim.schedule(function()
    vim.api.nvim_create_user_command('ClangdSwitchSourceHeader', function()
      local params = { uri = vim.uri_from_bufnr(0) }
      vim.lsp.buf_request(0, 'textDocument/switchSourceHeader', params, function(err, result)
        if err then
          error(tostring(err))
        end
        if not result then
          vim.notify('Corresponding file cannot be determined')
          return
        end
        vim.api.nvim_cmd({ cmd = 'edit', args = { vim.uri_to_fname(result) } }, {})
      end)
    end, { nargs = 0 })
  end)
end
