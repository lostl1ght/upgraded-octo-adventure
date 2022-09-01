local config = {}

function config.lspconfig()
  local lspconfig = require('modules.lsp.lspconfig')
  lspconfig.setup_signs()
  lspconfig.rust()
  lspconfig.lua()
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
      null.builtins.formatting.rustfmt,
    },
  })
end

function config.outline()
  require('symbols-outline').setup()
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

function config.fidget()
  require('fidget').setup({})
end

return config
