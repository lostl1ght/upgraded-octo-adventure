local config = {}

function config.rnvimr()
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_enable_bw = 1
  vim.g.rnvimr_layout = {
    relative = 'editor',
    width = math.floor(0.9 * vim.o.columns),
    height = math.floor(0.9 * vim.o.lines),
    col = math.floor(0.05 * vim.o.columns),
    row = math.floor(0.05 * vim.o.lines),
    style = 'minimal',
  }
end

function config.telescope()
  require('telescope').setup({
    pickers = {
      find_files = {
        hidden = true,
        previewer = false,
        layout_strategy = 'center',
        sorting_strategy = 'ascending',
        layout_config = {
          height = 0.5,
          width = 0.4,
          prompt_position = 'top',
        },
      },
      buffers = {
        previewer = false,
        layout_strategy = 'center',
        sorting_strategy = 'ascending',
        layout_config = {
          height = 0.5,
          width = 0.4,
          prompt_position = 'top',
        },
      },
      live_grep = {
        layout_strategy = 'vertical',
      },
      help_tags = {
        mappings = {
          i = {
            ['<cr>'] = 'select_vertical',
          },
          n = {
            ['<cr>'] = 'select_vertical',
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  })
  require('telescope').load_extension('fzf')
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

function config.bufresize()
  require('bufresize').setup({
    register = {
      keys = {},
      trigger_events = { 'BufWinEnter', 'WinEnter' },
    },
    resize = {
      keys = {},
      trigger_events = { 'VimResized' },
      increment = false,
    },
  })
end

function config.smart_splits()
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
