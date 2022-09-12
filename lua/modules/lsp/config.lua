local config = {}

function config.lspconfig()
  require('modules.lsp.lspconfig').setup()
end

function config.lspsaga()
  local lspconfig = require('modules.lsp.lspconfig')
  lspconfig.saga()
end

function config.null_ls()
  local null = require('null-ls')
  null.setup({
    sources = {
      null.builtins.formatting.stylua,
      null.builtins.formatting.rustfmt.with({
        extra_args = { '--edition', '2021' },
      }),
      null.builtins.formatting.fourmolu,
    },
  })
end

function config.outline()
  require('symbols-outline').setup({
    symbols = {
      File = { icon = ' ', hl = 'TSURI' },
      Module = { icon = ' ', hl = 'TSNamespace' },
      Namespace = { icon = ' ', hl = 'TSNamespace' },
      Package = { icon = ' ', hl = 'TSNamespace' },
      Class = { icon = ' ', hl = 'TSType' },
      Method = { icon = ' ', hl = 'TSMethod' },
      Property = { icon = ' ', hl = 'TSMethod' },
      Field = { icon = ' ', hl = 'TSField' },
      Constructor = { icon = ' ', hl = 'TSConstructor' },
      Enum = { icon = ' ', hl = 'TSType' },
      Interface = { icon = ' ', hl = 'TSType' },
      Function = { icon = ' ', hl = 'TSFunction' },
      Variable = { icon = ' ', hl = 'TSConstant' },
      Constant = { icon = ' ', hl = 'TSConstant' },
      String = { icon = ' ', hl = 'TSString' },
      Number = { icon = ' ', hl = 'TSNumber' },
      Boolean = { icon = ' ', hl = 'TSBoolean' },
      Array = { icon = ' ', hl = 'TSConstant' },
      Object = { icon = ' ', hl = 'TSType' },
      Key = { icon = ' ', hl = 'TSType' },
      Null = { icon = ' ', hl = 'TSType' },
      EnumMember = { icon = ' ', hl = 'TSField' },
      Struct = { icon = ' ', hl = 'TSType' },
      Event = { icon = ' ', hl = 'TSType' },
      Operator = { icon = ' ', hl = 'TSOperator' },
      TypeParameter = { icon = ' ', hl = 'TSParameter' },
    },
  })
end

function config.trouble()
  require('trouble').setup()
end

function config.signature()
  require('lsp_signature').setup({
    hint_prefix = '➜ ',
    handler_opts = {
      border = 'rounded',
    },
  })
end

function config.lsplines()
  vim.g.lsplines_enabled = false
  local lsplines = require('lsp_lines')
  lsplines.setup()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = vim.g.lsplines_enabled,
  })
  local lspconfig = require('modules.lsp.lspconfig')
  lspconfig.setup_signs()
end

return config
