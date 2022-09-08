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

function config.cinnamon()
  require('cinnamon').setup({
    default_keymaps = false,
  })
  -- DEFAULT_KEYMAPS:

  -- Half-window movements:
  vim.keymap.set({ 'n', 'x' }, '<C-u>', "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, '<C-d>', "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>")

  -- Page movements:
  vim.keymap.set({ 'n', 'x' }, '<C-b>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, '<C-f>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, '<PageUp>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, '<PageDown>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")

  -- EXTRA_KEYMAPS:

  -- Start/end of file and line number movements:
  vim.keymap.set({ 'n', 'x' }, 'gg', "<Cmd>lua Scroll('gg', 0, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, 'G', "<Cmd>lua Scroll('G', 0, 1)<CR>")

  -- Start/end of line:
  vim.keymap.set({ 'n', 'x' }, '0', "<Cmd>lua Scroll('0')<CR>")
  vim.keymap.set({ 'n', 'x' }, '^', "<Cmd>lua Scroll('^')<CR>")
  vim.keymap.set({ 'n', 'x' }, '$', "<Cmd>lua Scroll('$', 0, 1)<CR>")

  -- Paragraph movements:
  vim.keymap.set({ 'n', 'x' }, '{', "<Cmd>lua Scroll('{')<CR>")
  vim.keymap.set({ 'n', 'x' }, '}', "<Cmd>lua Scroll('}')<CR>")

  -- Previous/next search result:
  vim.keymap.set('n', 'n', "<Cmd>lua Scroll('n', 1)<CR>")
  vim.keymap.set('n', 'N', "<Cmd>lua Scroll('N', 1)<CR>")
  vim.keymap.set('n', '*', "<Cmd>lua Scroll('*', 1)<CR>")
  vim.keymap.set('n', '#', "<Cmd>lua Scroll('#', 1)<CR>")
  vim.keymap.set('n', 'g*', "<Cmd>lua Scroll('g*', 1)<CR>")
  vim.keymap.set('n', 'g#', "<Cmd>lua Scroll('g#', 1)<CR>")

  -- Previous/next cursor location:
  vim.keymap.set('n', '<C-o>', "<Cmd>lua Scroll('<C-o>', 1)<CR>")
  vim.keymap.set('n', '<C-i>', "<Cmd>lua Scroll('1<C-i>', 1)<CR>")

  -- Screen scrolling:
  vim.keymap.set('n', 'zz', "<Cmd>lua Scroll('zz', 0, 1)<CR>")
  vim.keymap.set('n', 'zt', "<Cmd>lua Scroll('zt', 0, 1)<CR>")
  vim.keymap.set('n', 'zb', "<Cmd>lua Scroll('zb', 0, 1)<CR>")
  vim.keymap.set('n', 'z.', "<Cmd>lua Scroll('z.', 0, 1)<CR>")
  vim.keymap.set('n', 'z<CR>', "<Cmd>lua Scroll('zt^', 0, 1)<CR>")
  vim.keymap.set('n', 'z-', "<Cmd>lua Scroll('z-', 0, 1)<CR>")
  vim.keymap.set('n', 'z^', "<Cmd>lua Scroll('z^', 0, 1)<CR>")
  vim.keymap.set('n', 'z+', "<Cmd>lua Scroll('z+', 0, 1)<CR>")
  vim.keymap.set('n', '<C-y>', "<Cmd>lua Scroll('<C-y>', 0, 1)<CR>")
  vim.keymap.set('n', '<C-e>', "<Cmd>lua Scroll('<C-e>', 0, 1)<CR>")

  -- Horizontal screen scrolling:
  vim.keymap.set('n', 'zH', "<Cmd>lua Scroll('zH')<CR>")
  vim.keymap.set('n', 'zL', "<Cmd>lua Scroll('zL')<CR>")
  vim.keymap.set('n', 'zs', "<Cmd>lua Scroll('zs')<CR>")
  vim.keymap.set('n', 'ze', "<Cmd>lua Scroll('ze')<CR>")
  vim.keymap.set('n', 'zh', "<Cmd>lua Scroll('zh', 0, 1)<CR>")
  vim.keymap.set('n', 'zl', "<Cmd>lua Scroll('zl', 0, 1)<CR>")
end

function config.surround()
  require('nvim-surround').setup()
end

function config.registers()
  vim.g.registers_window_border = 'single'
end

return config
