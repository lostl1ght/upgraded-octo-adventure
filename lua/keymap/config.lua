local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local remap = keymap.remap
local cmd = keymap.cmd

vim.g.mapleader = ' '

xmap({ ' ', '' })

nmap({
  { ' ', '' },
  { '<f1>', '', opts(remap) },
  { '<leader>h', cmd('noh'), opts('Basic: no highlight') },
  { '<leader>s', cmd('silent w'), opts('Basic: save') },
  {
    '<leader>`',
    function()
      pcall(vim.cmd, 'b#')
    end,
    opts('Buffer: switch'),
  },
  { 'Q', 'q', opts('Macro') },
  { 'q', '', opts(remap) },
  { '<c-l>', '<c-w>l', opts('Window: right') },
  { '<c-k>', '<c-w>k', opts('Window: up') },
  { '<c-j>', '<c-w>j', opts('Window: down') },
  { '<c-h>', '<c-w>h', opts('Window: left') },
})

imap({
  { 'ii', '<esc>' },
  { '<f1>', '', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })
