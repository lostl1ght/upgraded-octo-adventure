local config = {}

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
}

function config.lsp_formatting(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
  vim.cmd('silent w')
end

function config.setup_signs()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end
end

local servers = {}

function servers.rust_analyzer()
  require('lspconfig').rust_analyzer.setup({
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
    handlers = handlers,
  })
end

function servers.sumneko_lua()
  require('lspconfig').sumneko_lua.setup({
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
  })
end

function servers.hls()
  require('lspconfig').hls.setup({ handlers = handlers })
end

function servers.texlab()
  require('lspconfig').texlab.setup({
    handlers = handlers,
    settings = {
      texlab = {
        auxDirectory = 'latex.out',
        bibtexFormatter = 'texlab',
        build = {
          args = { '%f' },
          executable = 'latexrun',
          forwardSearchAfter = false,
          onSave = false,
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false,
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          executable = 'evince',
          args = { '%p' },
        },
        latexFormatter = 'latexindent',
        latexindent = {
          modifyLineBreaks = false,
        },
      },
    },
  })
end

function servers.gopls()
  require('lspconfig').gopls.setup({ handlers = handlers })
end

function servers.pyright()
  require('lspconfig').pyright.setup({ handlers = handlers })
end

function config.setup()
  for _, func in pairs(servers) do
    func()
  end
end

return config
