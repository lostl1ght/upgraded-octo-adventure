local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local desc, noremap = keymap.desc, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

vim.g.mapleader = ' '

nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

nmap({
  { '<f1>', '<nop>', opts() },
  { '<leader>h', cmd('noh'), opts(noremap, 'Basic: no highlight') },
  { '<leader>s', cmd('w'), opts(noremap, 'Basic: save') },
  { '<leader>`', cmd('b#'), opts(noremap, 'Buffer: switch') },
})

imap({
  { 'ii', '<esc>', opts(noremap) },
  { '<f1>', '<nop>', opts() },
})

tmap({
  { 'ii', '<c-\\><c-n>', opts(noremap) },
  { '<esc>', '<c-\\><c-n>', opts(noremap) }
})
