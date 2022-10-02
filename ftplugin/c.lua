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
