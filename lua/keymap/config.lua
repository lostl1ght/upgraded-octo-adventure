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
  {
    '<leader>`',
    function()
      pcall(vim.cmd, 'b#')
    end,
    opts('Buffer: switch'),
  },
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
        vim.cmd('Bd')
      end
    end,
    opts('Buffer: close'),
  },
  { '<leader>C', cmd('Bd!'), opts('Buffer: force close') },
})

imap({
  { 'ii', '<esc>' },
  { '<f1>', '', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })
