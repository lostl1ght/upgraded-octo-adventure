local config = {}

function config.lspconfig()
  local lspconfig = require('modules.lsp.lspconfig')
  lspconfig.setup()
  lspconfig.setup_signs()
end

function config.null_ls()
  local null = require('null-ls')
  null.setup({
    sources = {
      null.builtins.formatting.stylua,
      null.builtins.formatting.rustfmt.with({
        extra_args = { '--edition', '2021' },
      }),
    },
  })
end

function config.trouble()
  require('trouble').setup({
    position = 'top',
  })
end

function config.signature()
  require('lsp_signature').setup({
    doc_lines = 0,
    hint_enable = false,
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
end

function config.lightbulb()
  require('nvim-lightbulb').setup({
    sign = {
      enabled = false,
    },
    virtual_text = {
      enabled = true,
      text = '',
      hl_mode = 'combine',
    },
    autocmd = { enabled = true },
  })
  vim.api.nvim_set_hl(0, 'LightBulbVirtualText', { fg = '#dca561' })
end

function config.codeaction()
  vim.g.code_action_menu_show_diff = false
end

function config.luadev()
  require('lua-dev').setup({
    override = function(root_dir, library)
      if require('lua-dev.util').has_file(root_dir, '~/dev/nvim') then
        library.enabled = true
        library.runtime = true
        library.types = true
        library.plugins = true
      end
    end,
  })
end

function config.aerial()
  require('aerial').setup({
    backends = { 'lsp', 'treesitter' },
    filter_kind = {
      'Class',
      'Constant',
      'Constructor',
      'Enum',
      'EnumMember',
      'Event',
      'Field',
      'Function',
      'Interface',
      'Key',
      'Method',
      'Module',
      'Namespace',
      'Property',
      'Struct',
      'TypeParameter',
      'Variable',
    },
  })
end

return config
