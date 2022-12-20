local M = { 'folke/noice.nvim' }

M.event = 'VeryLazy'

M.dependencies = {
  'MunifTanjim/nui.nvim',
}

M.config = function()
  require('noice').setup({
    cmdline = {
      view = 'cmdline',
      format = {
        search_down = {
          view = 'cmdline',
        },
        search_up = {
          view = 'cmdline',
        },
      },
    },
    messages = {
      view = 'mini',
      view_error = 'mini',
      view_warn = 'mini',
    },
    popupmenu = {
      backend = 'cmp',
    },
    notify = {
      view = 'mini',
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      hover = {
        opts = {
          position = { row = 2, col = 2 },
        },
      },
      signature = {
        opts = {
          position = { row = 2, col = 2 },
        },
      },
      message = {
        view = 'mini',
      },
      documentation = {
        opts = {
          border = { style = 'single', padding = { 0, 0 } },
        },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = '10%',
          col = '50%',
        },
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = 'search_count',
        },
        opts = { skip = true },
      },
    },
  })
end

return M
