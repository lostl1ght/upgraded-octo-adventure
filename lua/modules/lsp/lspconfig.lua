local config = {}

local function setup_document_highlight(client, bufnr)
  local status_ok, highlight_supported = pcall(function()
    return client.supports_method('textDocument/documentHighlight')
  end)

  if not status_ok or not highlight_supported then
    return
  end
  local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
    group = 'lsp_document_highlight',
  })
  if not augroup_exist then
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
  end
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

function config.lsp_formatting(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

function config.setup_signs()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end
end

local function common_attach(client, bufnr)
  local navic = require('nvim-navic')
  navic.attach(client, bufnr)
  setup_document_highlight(client, bufnr)
end

function config.rust()
  require('lspconfig').rust_analyzer.setup({
    on_attach = function(client, bufnr)
      common_attach(client, bufnr)
    end,
  })
end

function config.lua()
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
    on_attach = function(client, bufnr)
      common_attach(client, bufnr)
    end,
  })
end

function config.saga()
  local saga = require('lspsaga')

  saga.init_lsp_saga({
    border_style = 'single',
    saga_winblend = 0,
    move_in_saga = { prev = '<C-p>', next = '<C-n>' },
    diagnostic_header = { ' ', ' ', ' ', ' ' },
    show_diagnostic_source = true,
    diagnostic_source_bracket = {},
    max_preview_lines = 10,
    code_action_icon = '',
    code_action_num_shortcut = true,
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = false,
      cache_code_action = true,
      sign = false,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
    finder_icons = {
      def = '  ',
      ref = '諭 ',
      link = '  ',
    },
    finder_request_timeout = 3000,
    finder_preview_hl_ns = 0,
    finder_action_keys = {
      open = '<enter>',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      quit = 'q',
      scroll_down = '<C-f>',
      scroll_up = '<C-b>',
    },
    code_action_keys = {
      quit = 'q',
      exec = '<CR>',
    },
    rename_action_quit = '<C-c>',
    rename_in_select = true,
    definition_preview_icon = '  ',
    symbol_in_winbar = {
      in_custom = false,
      enable = false,
      separator = ' ',
      show_file = true,
      click_support = false,
    },
    show_outline = {
      win_position = 'right',
      win_with = '',
      win_width = 30,
      auto_enter = true,
      auto_preview = true,
      virt_text = '┃',
      jump_key = 'o',
      auto_refresh = true,
    },
  })
end

return config
