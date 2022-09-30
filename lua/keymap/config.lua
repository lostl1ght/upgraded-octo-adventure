local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local remap = keymap.remap
local cmd = keymap.cmd

vim.g.mapleader = ' '

nmap({ ' ', '' })
xmap({ ' ', '' })

nmap({
  { '<f1>', '', opts(remap) },
  { '<leader>h', cmd('noh'), opts('Basic: no highlight') },
  { '<leader>s', cmd('silent w'), opts('Basic: save') },
  { '<leader>`', cmd('b#'), opts('Buffer: switch') },
  { 'Q', 'q', opts('Macro') },
  { 'q', '', opts(remap) },
  {
    '<leader>c',
    function()
      if vim.o.modified then
        vim.notify('Save before closing')
      elseif vim.o.buftype == 'terminal' then
        vim.notify('Kill the terminal')
      else
        vim.cmd('bd')
      end
    end,
    opts('Buffer: close'),
  },
  { '<leader>C', cmd('bd!'), opts('Buffer: force close') },
  { '<c-l>', '<c-w>l', opts('Window: focus left') },
  { '<c-h>', '<c-w>h', opts('Window: focus right') },
  { '<c-j>', '<c-w>j', opts('Window: focus down') },
  { '<c-k>', '<c-w>k', opts('Window: focus up') },
})

imap({
  { 'ii', '<esc>' },
  { '<f1>', '', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })
