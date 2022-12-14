local cache_dir = vim.fn.stdpath('cache')

vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h10' }
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '»·', nbsp = '+', trail = '·', extends = '→', precedes = '←' }
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.virtualedit = { 'block' }
vim.opt.shiftround = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. '/swap'
vim.opt.undodir = cache_dir .. '/undo'
vim.opt.backupdir = cache_dir .. '/backup'
vim.opt.viewdir = cache_dir .. '/view'
vim.opt.history = 2000
vim.opt.shada = "!,'300,<50,@100,s10,h"
vim.opt.backupskip = {
  '/tmp/*',
  '$TMPDIR/*',
  '$TMP/*',
  '$TEMP/*',
  '*/shm/*',
  '/private/var/*',
  '.vault.vim',
}
vim.opt.redrawtime = 1500
vim.opt.ignorecase = false
vim.opt.equalalways = false
vim.opt.whichwrap = '<,>,[,]'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.ruler = false
vim.opt.showtabline = 2
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.breakindentopt = { shift = 2, min = 20 }
vim.opt.fillchars = { diff = '╱' }
vim.opt.cmdheight = 0
vim.opt.timeoutlen = 500
vim.opt.shortmess:append('I')
vim.g.tex_flavor = 'latex'
vim.g.python3_host_prog = vim.env.HOME .. '/.pyenv/versions/neovim/bin/python3'
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.mapleader = ' '
