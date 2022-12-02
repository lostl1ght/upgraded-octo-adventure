local config = {}

-- Treesitter
function config.treesitter()
  require('nvim-treesitter.configs').setup({
    playground = {
      enable = true,
    },
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
      'gitcommit',
      'gitignore',
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
function config.leap()
  require('leap').add_default_mappings()
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

function config.lir()
  local actions = require('lir.actions')
  local mark_actions = require('lir.mark.actions')
  local clipboard_actions = require('lir.clipboard.actions')
  require('lir').setup({
    show_hidden_files = false,
    devicons_enable = true,
    mappings = {
      ['l'] = actions.edit,
      ['<C-s>'] = actions.split,
      ['<C-v>'] = actions.vsplit,
      ['<C-t>'] = actions.tabedit,

      ['h'] = actions.up,
      ['q'] = actions.quit,

      ['K'] = actions.mkdir,
      ['N'] = actions.newfile,
      ['R'] = actions.rename,
      ['@'] = actions.cd,
      ['Y'] = actions.yank_path,
      ['.'] = actions.toggle_show_hidden,
      ['D'] = actions.delete,

      ['J'] = function()
        mark_actions.toggle_mark()
        vim.cmd('normal! j')
      end,
      ['C'] = clipboard_actions.copy,
      ['X'] = clipboard_actions.cut,
      ['P'] = clipboard_actions.paste,
    },
    float = {
      win_opts = function()
        return {
          border = 'single',
        }
      end,
    },
  })
  require('lir.git_status').setup({
    show_ignored = false,
  })
  vim.api.nvim_set_hl(0, 'LirFloatBorder', { link = 'FloatermBorder' })
end

function config.winshift()
  require('winshift').setup({ focused_hl_group = 'Visual' })
end

function config.reach()
  require('reach').setup({
    notifications = true,
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
