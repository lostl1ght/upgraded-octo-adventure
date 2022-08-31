local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local buffers = Hydra({
  name = 'Buffers',
  heads = {
    { 'l', cmd('bn'), { desc = 'next buf' } },
    { 'h', cmd('bp'), { desc = 'prev buf' } },
    { 'c', cmd('bd'), { desc = 'close' } },
    { '`', cmd('b#'), { desc = 'switch' } },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local gitsigns = require('gitsigns')

local git_hint = [[
_K_: prev hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line       _r_: reset hunk
_J_: next hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full  _R_: reset buffer
_g_: neogit      _S_: stage buffer      ^ ^                 _/_: show base file
_q_: exit
]]

local git = Hydra({
  name = 'Git',
  hint = git_hint,
  config = {
    buffer = bufnr,
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'rounded',
    },
    on_enter = function()
      vim.cmd('mkview')
      vim.cmd('silent! %foldopen!')
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd('loadview')
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd('normal zv')
      gitsigns.toggle_linehl(false)
    end,
  },
  heads = {
    {
      'J',
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'next hunk' },
    },
    {
      'K',
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'prev hunk' },
    },
    { 's', gitsigns.stage_hunk, { silent = true, desc = 'stage hunk' } },
    { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
    { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
    { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
    { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
    { 'b', gitsigns.blame_line, { desc = 'blame' } },
    { 'R', gitsigns.reset_buffer, { desc = 'reset buffer' } },
    { 'r', gitsigns.reset_hunk, { desc = 'reset buffer' } },
    {
      'B',
      function()
        gitsigns.blame_line({ full = true })
      end,
      { desc = 'blame show full' },
    },
    { '/', gitsigns.show, { exit = true, desc = 'show base file' } },
    { 'g', ':Neogit<cr>', { exit = true, desc = 'neogit', nowait = true } },
    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
  },
})

local lsp = Hydra({
  name = 'Lsp',
  heads = {
    { 'J', cmd('Lspsaga diagnostic_jump_next'), { desc = 'next diag' } },
    { 'K', cmd('Lspsaga diagnostic_jump_prev'), { desc = 'prev diag' } },
    { 'd', cmd('Lspsaga show_line_diagnostics'), { desc = 'line diag' } },
    { 't', cmd('TroubleToggle'), { exit = true, desc = 'trouble' } },
    { 's', cmd('SymbolsOutline'), { exit = true, desc = 'outline' } },
    { '<Esc>', nil, { desc = false, exit = true } },
  },
})

local splits = require('smart-splits')
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

local function choose_buffer()
  if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
    buffers:activate()
  end
end

local windows = Hydra({
  name = 'Windows',
  hint = window_hint,
  config = {
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

local config = {
  buffers = buffers,
  git = git,
  lsp = lsp,
  windows = windows,
}

return config
