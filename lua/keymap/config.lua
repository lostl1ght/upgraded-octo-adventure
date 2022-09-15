local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local remap = keymap.remap
local cmd, pcmd = keymap.cmd, keymap.pcmd

vim.g.mapleader = ' '

nmap({ ' ', '' })
xmap({ ' ', '' })

nmap({
  { '<f1>', '<nop>', opts(remap) },
  { '<leader>h', cmd('noh'), opts('Basic: no highlight') },
  { '<leader>s', cmd('w'), opts('Basic: save') },
  { '<leader>`', cmd('b#'), opts('Buffer: switch') },
  { 'Q', 'q', opts('Macro') },
  { 'q', '<nop>', opts(remap) },
  { '<leader>c', pcmd('bd', 'E89', 'echo "Save before closing"'), opts('Buffer: close') },
  { '<leader>C', cmd('bd!'), opts('Buffer: force close') },
})

imap({
  { 'ii', '<esc>' },
  { '<f1>', '<nop>', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })
