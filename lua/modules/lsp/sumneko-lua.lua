local config = {}

function config.setup()
  local utils = require('modules.lsp.utils')
  require('lspconfig').sumneko_lua.setup({
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
    handlers = utils.setup_border(),
    on_attach = function(client, bufnr)
      utils.common_attach(client, bufnr)
    end,
  })
end

return config
