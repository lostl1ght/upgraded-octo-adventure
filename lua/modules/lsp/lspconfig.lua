local config = {}

local function setup_document_highlight(client, bufnr)
  local status_ok, highlight_supported = pcall(function()
    return client.supports_method('textDocument/documentHighlight')
  end)

  if not status_ok or not highlight_supported then
    return
  end
  local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
    group = 'lsp_document_highlight',
  })
  if not augroup_exist then
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
  end
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

function config.lsp_formatting(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
  vim.cmd('w')
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

local function common_attach(client, bufnr)
  local navic = require('nvim-navic')
  navic.attach(client, bufnr)
  setup_document_highlight(client, bufnr)
end

local servers = {}

function servers.rust_analyzer()
  require('lspconfig').rust_analyzer.setup({
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
    on_attach = function(client, bufnr)
      common_attach(client, bufnr)
    end,
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
    on_attach = function(client, bufnr)
      common_attach(client, bufnr)
    end,
  })
end

function servers.hls()
  require('lspconfig').hls.setup({
    on_attach = function(client, bufnr)
      common_attach(client, bufnr)
    end,
  })
end

function config.setup()
  for _, func in pairs(servers) do
    func()
  end
end

function config.saga()
  local saga = require('lspsaga')

  saga.init_lsp_saga({
    diagnostic_header = { ' ', ' ', ' ', ' ' },
    code_action_icon = '',
    code_action_lightbulb = {
      enable_in_insert = false,
      sign = false,
    },
    finder_icons = {
      def = '  ',
      ref = '  ',
      link = '  ',
    },
    finder_request_timeout = 3000,
    finder_action_keys = {
      open = '<enter>',
    },
  })
end

return config
