local M = { 'neovim/nvim-lspconfig' }

M.ft = {
  'bib',
  'c',
  'cpp',
  'css',
  'html',
  'htmldjango',
  'lua',
  'python',
  'rust',
  'tex',
}

M.dependencies = {
  { 'folke/neodev.nvim' },
  {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      vim.g.lsplines_enabled = false
      require('lsp_lines').setup()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = vim.g.lsplines_enabled,
      })
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    config = function()
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
    end,
  },
}

M.config = function()
  require('neodev').setup({
    override = function(root_dir, library)
      if require('neodev.util').has_file(root_dir, '~/dev/nvim') then
        library.enabled = true
        library.runtime = true
        library.types = true
        library.plugins = true
      end
    end,
    lspconfig = false,
  })

  local lspconfig = require('lspconfig')

  lspconfig.sumneko_lua.setup({
    name = 'sumneko-lua',
    cmd = { 'lua-language-server' },
    before_init = require('neodev.lsp').before_init,
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
        completion = { autoRequire = false, keywordSnippet = 'Disable' },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  })

  lspconfig.rust_analyzer.setup({
    name = 'rust-analyzer',
    cmd = { 'rust-analyzer' },
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.offsetEncoding = { 'utf-16' }
  lspconfig.clangd.setup({
    name = 'clangd',
    cmd = { 'clangd' },
    capabilities = capabilities,
  })

  lspconfig.texlab.setup({
    name = 'texlab',
    cmd = { 'texlab' },
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
  lspconfig.pyright.setup({})
  lspconfig.emmet_ls.setup({
    init_options = {
      html = {
        options = {
          ['output.indent'] = '  ',
        },
      },
    },
  })
end

return M
