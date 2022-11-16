local config = {}

-- Treesitter
function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      -- basic
      'bash',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'regex',
      'toml',
      'vim',
      'yaml',

      -- needed
      'c',
      'cpp',
      'css',
      'fish',
      'git_rebase',
      'gitattributes',
      'gitignore',
      'html',
      'http',
      'proto',
      'python',
      'rust',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
  require('tree-sitter-just').setup({})
end

-- Editing
function config.autopairs()
  require('nvim-autopairs').setup()
end

function config.surround()
  require('nvim-surround').setup()
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
      { open = '$', close = '$' },
    },
    ignore_beginning = true,
  })
end

function config.ai()
  require('mini.ai').setup()
end

-- Navigation
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

function config.lf()
  vim.g.lf_hijack_netrw = true
  vim.api.nvim_set_hl(0, 'LfBorder', { link = 'FloatermBorder' })
  vim.api.nvim_set_hl(0, 'LfNormal', { link = 'Normal' })
  require('lf').setup({
    lfrc = vim.fs.normalize('~/.config/lf/lfrc_nvim'),
    border = 'single',
  })
end

function config.winshift()
  require('winshift').setup({ focused_hl_group = 'Visual' })
end

function config.cybu()
  require('cybu').setup({
    style = {
      border = 'single',
    },
    display_time = 1250,
  })
end

function config.tmux()
  require('tmux').setup({
    copy_sync = {
      enable = false,
    },
    navigation = {
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = false,
      resize_step_x = 3,
      resize_step_y = 3,
    },
  })
end

-- Other tools
function config.persistence()
  require('persistence').setup({
    dir = vim.fs.normalize(vim.fn.stdpath('data') .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
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

return config
