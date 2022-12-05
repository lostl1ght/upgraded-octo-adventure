local config = {}

function config.lspconfig()
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
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        '.luarc.json',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        '.git',
      }, { upward = true })[1]) or vim.loop.cwd()
    end,
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
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        'Cargo.toml',
        'rust-project.json',
        '.git',
      }, { upward = true })[1])
    end,
    settings = { ['rust-analyzer'] = { completion = { postfix = { enable = false } } } },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.offsetEncoding = { 'utf-16' }
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
      }, { upward = true })[1]) or vim.loop.cwd()
    end,
    capabilities = capabilities,
  })

  lspconfig.texlab.setup({
    name = 'texlab',
    cmd = { 'texlab' },
    root_dir = function()
      return vim.fs.dirname(vim.fs.find({
        '.latexmkrc',
        '.git',
      }, { upward = true })[1]) or vim.loop.cwd()
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
        extra_args = {
          '-c',
          '/tmp',
          '-m',
          '-l',
          vim.fs.normalize('~/.config/latexindent/defaultSettings.yaml'),
        },
      }),
      null.builtins.formatting.clang_format,
      null.builtins.formatting.prettier.with({
        filetypes = { 'htmldjango' },
      }),
    },
  })
end

function config.trouble()
  require('trouble').setup({
    position = 'top',
  })
end

function config.lsplines()
  vim.g.lsplines_enabled = false
  require('lsp_lines').setup()
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
end

function config.codeaction()
  vim.g.code_action_menu_show_diff = false
end

function config.aerial()
  require('aerial').setup({
    backends = { 'lsp', 'treesitter' },
    filter_kind = false,
  })
end

function config.glance()
  require('glance').setup({
    hooks = {
      before_open = function(results, open, jump, method)
        local uri = vim.uri_from_bufnr(0)
        if #results == 1 then
          local target_uri = results[1].uri or results[1].targetUri

          if target_uri == uri then
            jump(results[1])
          else
            open(results)
          end
        else
          open(results)
        end
      end,
    },
  })
end

function config.navic()
  require('nvim-navic').setup({
    icons = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
    highlight = true,
  })

  local groups = {
    { 'NavicIconsFile', { link = '@text.uri' } },
    { 'NavicIconsModule', { link = '@namespace' } },
    { 'NavicIconsNamespace', { link = '@namespace' } },
    { 'NavicIconsPackage', { link = '@namespace' } },
    { 'NavicIconsClass', { link = '@type' } },
    { 'NavicIconsMethod', { link = '@method' } },
    { 'NavicIconsProperty', { link = '@method' } },
    { 'NavicIconsField', { link = '@field' } },
    { 'NavicIconsConstructor', { link = '@constructor' } },
    { 'NavicIconsEnum', { link = '@type' } },
    { 'NavicIconsInterface', { link = '@type' } },
    { 'NavicIconsFunction', { link = '@function' } },
    { 'NavicIconsVariable', { link = '@constant' } },
    { 'NavicIconsConstant', { link = '@constant' } },
    { 'NavicIconsString', { link = '@string' } },
    { 'NavicIconsNumber', { link = '@number' } },
    { 'NavicIconsBoolean', { link = '@boolean' } },
    { 'NavicIconsArray', { link = '@constant' } },
    { 'NavicIconsObject', { link = '@type' } },
    { 'NavicIconsKey', { link = '@type' } },
    { 'NavicIconsNull', { link = '@type' } },
    { 'NavicIconsEnumMember', { link = '@field' } },
    { 'NavicIconsStruct', { link = '@type' } },
    { 'NavicIconsEvent', { link = '@type' } },
    { 'NavicIconsOperator', { link = '@operator' } },
    { 'NavicIconsTypeParameter', { link = '@parameter' } },
    { 'NavicSeparator', { link = 'Comment' } },
  }
  for _, v in ipairs(groups) do
    vim.api.nvim_set_hl(0, unpack(v))
  end
end

return config
