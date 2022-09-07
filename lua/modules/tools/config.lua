local config = {}

function config.nvimtree()
  require('nvim-tree').setup({
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
  })
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
    cwd_change_handling = {
      restore_upcoming_session = true,
    },
  })
end

function config.smart_splits()
  require('bufresize').setup()
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
