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

return config
