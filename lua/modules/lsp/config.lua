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

return config
