local config = {}

function config.rnvimr()
  vim.g.rnvimr_enable_bw = 1
  vim.g.rnvimr_layout = {
    relative = 'editor',
    width = math.floor(0.8 * vim.o.columns),
    height = math.floor(0.8 * vim.o.lines),
    col = math.floor(0.1 * vim.o.columns),
    row = math.floor(0.1 * vim.o.lines),
    style = 'minimal',
  }
end

function config.telescope()
  require('telescope').setup({
    pickers = {
      fd = {
        hidden = true,
        theme = 'dropdown',
      },
      live_grep = {
        theme = 'ivy',
      },
      help_tags = {
        theme = 'ivy',
        mappings = {
          i = {
            ['<cr>'] = 'select_vertical',
          },
          n = {
            ['<cr>'] = 'select_vertical',
          },
        },
      },
      buffers = {
        theme = 'dropdown',
      },
      keymaps = {
        theme = 'dropdown',
      },
    },
  })
end

function config.comment()
  require('Comment').setup({ ignore = '^$' })
end

function config.autosession()
  require('auto-session').setup({
    log_level = 'error',
    auto_session_root_dir = vim.fn.stdpath('cache') .. '/sessions/',
    auto_session_create_enabled = false,
    cwd_change_handling = nil,
  })
end

function config.smart_splits()
  require('bufresize').setup({})
  require('smart-splits').setup({
    resize_mode = {
      hooks = {
        on_leave = require('bufresize').register,
      },
    },
  })
end

function config.winshift()
  require('winshift').setup({
    keymaps = {
      disable_defaults = true,
    },
  })
end

function config.colorizer()
  require('colorizer').setup({
    filetypes = { '*' },
    user_default_options = {
      RGB = false,
      RRGGBB = true,
      names = false,
    },
  })
end

function config.langmap_switch()
  require('langmap_switch').setup({ keymap = 'russian-jcukenwin' })
end

return config
