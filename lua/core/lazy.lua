local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.api.nvim_cmd({
    cmd = '!',
    args = {
      'git',
      'clone',
      '--filter=blob:none',
      '--single-branch',
      'https://github.com/folke/lazy.nvim.git',
      lazy_path,
    },
  }, {})
end

vim.opt.runtimepath:prepend(lazy_path)

require('lazy').setup('plugins', {
  defaults = {
    lazy = true,
  },
  lockfile = vim.fn.stdpath('state') .. '/lazy-lock.json',
  dev = {
    path = '~/dev/plugins',
  },
  ui = {
    border = 'single',
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
