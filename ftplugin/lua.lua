vim.opt_local.shiftwidth = 2

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
}

vim.schedule(function()
  vim.lsp.start({
    name = 'sumneko-lua',
    cmd = { 'lua-language-server' },
    root_dir = vim.fs.dirname(vim.fs.find({
      '.luarc.json',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      '.git',
    }, { upward = true })[1]),
    settings = {
      Lua = {
        completion = { autoRequire = false, keywordSnippet = 'Disable' },
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        telemetry = { enable = false },
      },
    },
    handlers = handlers,
    on_attach = require('aerial').on_attach,
  })
end)
