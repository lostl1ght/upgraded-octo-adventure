local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'go',
      'haskell',
      'latex',
      'lua',
      'python',
      'rust',
      'toml',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

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

function config.autopairs()
  require('nvim-autopairs').setup()
end

function config.tabout()
  require('tabout').setup({
    tabkey = '<Tab>',
    backwards_tabkey = '<S-Tab>',
    act_as_tab = true,
    act_as_shift_tab = false,
    default_tab = '<C-t>',
    default_shift_tab = '<C-d>',
    enable_backwards = true,
    completion = true,
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = '`', close = '`' },
      { open = '(', close = ')' },
      { open = '[', close = ']' },
      { open = '{', close = '}' },
      { open = '<', close = '>' },
    },
    ignore_beginning = true,
  })
end

function config.neoscroll()
  require('neoscroll').setup({
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    hide_cursor = false,
  })
end

function config.surround()
  require('nvim-surround').setup()
end

function config.comment()
  require('Comment').setup({ ignore = '^$' })
end

function config.autosession()
  require('auto-session').setup({
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

function config.registers()
  vim.g.registers_window_border = 'single'
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

return config
