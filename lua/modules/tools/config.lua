local config = {}

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

function config.session()
  require('session_manager').setup({
    sessions_dir = vim.fn.stdpath('cache') .. '/sessions/',
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
    autosave_only_in_session = true,
  })
end

function config.smart_splits()
  require('smart-splits').setup({
    resize_mode = {
      quit_key = 'q',
    },
  })
end

function config.winshift()
  require('winshift').setup({})
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

function config.just()
  require('tree-sitter-just').setup({})
end

function config.lf()
  require('lf').setup({
    lfrc = vim.fs.normalize('~/.config/lf/lfrc_nvim'),
    border = 'single',
  })
end

return config
