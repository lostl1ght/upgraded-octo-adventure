local cache_dir = os.getenv('HOME') .. '/.cache/nvim/'

vim.g.onedark_style = 'warm'
vim.g.tex_flavor = 'latex'
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.opt.termguicolors = true
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h11' }
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.virtualedit = 'block,onemore'
vim.opt.shiftround = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. 'swap/'
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'
vim.opt.viewdir = cache_dir .. 'view/'
vim.opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
vim.opt.history = 2000
vim.opt.shada = "!,'300,<50,@100,s10,h"
vim.opt.backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
vim.opt.redrawtime = 1500
vim.opt.ignorecase = false
vim.opt.equalalways = false
vim.opt.whichwrap = '<,>,[,]'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.jumpoptions = 'stack'
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.ruler = false
vim.opt.showtabline = 2
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 5
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:2,min:20'
vim.opt.fillchars = 'diff:╱'
