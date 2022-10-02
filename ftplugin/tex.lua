local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
}

local texlab_build_status = vim.tbl_add_reverse_lookup({
  Success = 0,
  Error = 1,
  Failure = 2,
  Cancelled = 3,
})

local texlab_forward_status = vim.tbl_add_reverse_lookup({
  Success = 0,
  Error = 1,
  Failure = 2,
  Unconfigured = 3,
})

vim.schedule(function()
  vim.lsp.start({
    name = 'texlab',
    cmd = { 'texlab' },
    root_dir = vim.fs.dirname(vim.fs.find({
      '.git',
    }, { upward = true })[1]),
    handlers = handlers,
    on_attach = require('aerial').on_attach,
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

  vim.api.nvim_create_user_command('TexlabBuild', function()
    local params = {
      textDocument = { uri = vim.uri_from_bufnr(0) },
    }
    vim.lsp.buf_request(0, 'textDocument/build', params, function(err, result)
      if err then
        error(tostring(err))
      end
      vim.notify('Build ' .. texlab_build_status[result.status])
    end)
  end)

  vim.api.nvim_create_user_command('TexlabForward', function()
    local params = {
      textDocument = { uri = vim.uri_from_bufnr(0) },
      position = { line = vim.fn.line('.') - 1, character = vim.fn.col('.') },
    }
    vim.lsp.buf_request(0, 'textDocument/forwardSearch', params, function(err, result)
      if err then
        error(tostring(err))
      end
      vim.notify('Search ' .. texlab_forward_status[result.status])
    end)
  end)
end)
