local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local cmd = keymap.cmd

vim.g.mapleader = ' '

nmap({ ' ', '' })
xmap({ ' ', '' })

nmap({
  { '<f1>', '<nop>' },
  { '<leader>h', cmd('noh'), opts('Basic: no highlight') },
  { '<leader>s', cmd('w'), opts('Basic: save') },
  { '<leader>`', cmd('b#'), opts('Buffer: switch') },
})

imap({
  { 'ii', '<esc>' },
  { '<f1>', '<nop>' },
})

tmap({
  { 'ii', '<c-\\><c-n>' },
  { '<esc>', '<c-\\><c-n>' },
})
