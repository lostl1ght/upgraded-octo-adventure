local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'jsonc',
      'lua',
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

function config.cinnamon()
  require('cinnamon').setup({
    default_keymaps = false,
    scroll_limit = 75,
    default_delay = 4,
  })
  -- Start/end of file and line number movements:
  vim.keymap.set({ 'n', 'x' }, 'gg', "<Cmd>lua Scroll('gg', 0, 1)<CR>", {})
  vim.keymap.set({ 'n', 'x' }, 'G', "<Cmd>lua Scroll('G', 0, 1)<CR>", {})

  -- Previous/next search result:
  vim.keymap.set('n', 'n', "<Cmd>lua Scroll('n', 1)<CR>", {})
  vim.keymap.set('n', 'N', "<Cmd>lua Scroll('N', 1)<CR>", {})

  -- Screen scrolling:
  vim.keymap.set('n', 'zz', "<Cmd>lua Scroll('zz', 0, 1)<CR>", {})
  vim.keymap.set('n', 'zt', "<Cmd>lua Scroll('zt', 0, 1)<CR>", {})
  vim.keymap.set('n', 'zb', "<Cmd>lua Scroll('zb', 0, 1)<CR>", {})
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

function config.matchup()
  vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  require('nvim-treesitter.configs').setup({
    matchup = {
      enable = true,
      include_match_words = true,
    },
  })
end

function config.tmux()
  local tmux = require('tmux')
  tmux.setup({
    copy_sync = {
      enable = false,
    },
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = false,
    },
  })
  vim.keymap.set('n', '<c-h>', tmux.move_left, {})
  vim.keymap.set('n', '<c-j>', tmux.move_bottom, {})
  vim.keymap.set('n', '<c-k>', tmux.move_top, {})
  vim.keymap.set('n', '<c-l>', tmux.move_right, {})
end

return config
