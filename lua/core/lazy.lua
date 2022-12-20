local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if vim.loop.fs_stat(lazy_path) then
  vim.opt.runtimepath:prepend(lazy_path)
else
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
  vim.opt.runtimepath:prepend(lazy_path)
  require('lazy').install()
end

require('lazy').setup('plugins', {
  defaults = {
    lazy = true,
  },
  dev = {
    path = '~/dev/plugins',
  },
  ui = {
    border = 'single'
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
