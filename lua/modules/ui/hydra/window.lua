local Hydra = require('hydra')
local splits = require('smart-splits')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local window_hint = [[
^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
_h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
_b_: choose buffer          ^   _w_: switch
_q_: exit
]]

local buffer_hydra = require('modules.ui.hydra.buffer')

local function choose_buffer()
  if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
    buffer_hydra:activate()
  end
end

local hydra = Hydra({
  name = 'Windows',
  hint = window_hint,
  config = {
    invoke_on_body = true,
    hint = {
      border = 'rounded',
      offset = -1,
    },
  },
  heads = {
    { 'h', cmd('KittyNavigateLeft') },
    { 'j', cmd('KittyNavigateDown') },
    { 'k', cmd('KittyNavigateUp') },
    { 'l', cmd('KittyNavigateRight') },

    { 'H', cmd('WinShift left') },
    { 'J', cmd('WinShift down') },
    { 'K', cmd('WinShift up') },
    { 'L', cmd('WinShift right') },

    {
      '<C-h>',
      function()
        splits.resize_left(2)
      end,
    },
    {
      '<C-j>',
      function()
        splits.resize_down(2)
      end,
    },
    {
      '<C-k>',
      function()
        splits.resize_up(2)
      end,
    },
    {
      '<C-l>',
      function()
        splits.resize_right(2)
      end,
    },
    { '=', '<C-w>=', { desc = 'equalize' } },

    { 's', pcmd('split', 'E36') },
    { 'v', pcmd('vsplit', 'E36') },
    { 'w', '<C-w>w', { exit = true } },
    { 'z', cmd('MaximizerToggle!'), { desc = 'maximize' } },
    { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
    { 'c', pcmd('close', 'E444') },

    { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

    { 'q', nil, { exit = true } },
  },
})

return hydra
