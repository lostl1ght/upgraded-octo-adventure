local config = {}

function config.setup()
  local utils = require('modules.lsp.utils')
  require('lspconfig').rust_analyzer.setup({
    handlers = utils.setup_border(),
    on_attach = function(client, bufnr)
      utils.common_attach(client, bufnr)
    end,
  })
end

return config
