local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'jsonc',
      'lua',
      'markdown',
      'regex',
      'rust',
      'toml',
      'vim',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
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
      { open = '$', close = '$' },
    },
    ignore_beginning = true,
  })
end

function config.surround()
  require('nvim-surround').setup()
end

function config.registers()
  require('registers').setup({
    window = {
      border = 'single',
    },
  })
end

return config
