local config = {}

function config.lspconfig()
  local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
  }
  local aerial = require('aerial')
  local lspconfig = require('lspconfig')

  lspconfig.sumneko_lua.setup({
    name = 'sumneko-lua',
    cmd = { 'lua-language-server' },
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        '.luarc.json',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        '.git',
      }, { upward = true })[1])
    end,
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
    on_attach = aerial.on_attach,
  })

  lspconfig.rust_analyzer.setup({
    name = 'rust-analyzer',
    cmd = { 'rust-analyzer' },
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        'Cargo.toml',
        'rust-project.json',
        '.git',
      }, { upward = true })[1])
    end,
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
    handlers = handlers,
    on_attach = aerial.on_attach,
  })

  lspconfig.clangd.setup({
    name = 'clangd',
    cmd = { 'clangd' },
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        '.git',
      }, { upward = true })[1])
    end,
    handlers = handlers,
    on_attach = aerial.on_attach,
  })

  lspconfig.texlab.setup({
    name = 'texlab',
    cmd = { 'texlab' },
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        '.latexmkrc',
        '.git',
      }, { upward = true })[1])
    end,
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
    handlers = handlers,
    on_attach = aerial.on_attach,
  })
end

function config.null_ls()
  local null = require('null-ls')
  null.setup({
    sources = {
      null.builtins.formatting.stylua,
      null.builtins.formatting.rustfmt.with({
        extra_args = { '--edition', '2021' },
      }),
      null.builtins.formatting.latexindent.with({
        filetypes = { 'tex', 'bib' },
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
