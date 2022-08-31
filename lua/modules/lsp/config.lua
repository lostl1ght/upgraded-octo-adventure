local config = {}

function config.lspconfig()
  require('modules.lsp.utils').setup_signs()
  require('modules.lsp.sumneko-lua').setup()
  require('modules.lsp.rust-analyzer').setup()
end

function config.lspsaga()
  require('modules.lsp.saga').setup()
end

function config.fidget()
  require('fidget').setup({
    window = {
      relative = 'editor',
    },
  })
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

return config
