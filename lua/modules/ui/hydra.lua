local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local buffers = Hydra({
  name = 'Buffers',
  heads = {
    { ']', cmd('bn'), { desc = 'next buf' } },
    { '[', cmd('bp'), { desc = 'prev buf' } },
    { 'c', pcmd('bd', 'E89'), { desc = 'close' } },
    { 'C', cmd('bd!'), { desc = 'force close' } },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local gitsigns = require('gitsigns')

local git_hint = [[
_K_: prev hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line       _r_: reset hunk
_J_: next hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full  _R_: reset buffer
_g_: lazygit     _S_: stage buffer      ^ ^                 _/_: show base file
]]

local git = Hydra({
  name = 'Git',
  hint = git_hint,
  config = {
    color = 'pink',
    hint = {
      border = 'single',
    },
    on_enter = function()
      pcmd('mkview', 'E32')
      vim.cmd('silent! %foldopen!')
      vim.bo.modifiable = false
      vim.schedule(function()
        gitsigns.toggle_linehl(true)
      end)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      pcmd('loadview', 'E32')
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd('normal zv')
      vim.schedule(function()
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end)
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
    {
      'R',
      function()
        vim.bo.modifiable = true
        gitsigns.reset_buffer()
        vim.bo.modifiable = false
      end,
      { desc = 'reset buffer' },
    },
    {
      'r',
      function()
        vim.bo.modifiable = true
        gitsigns.reset_hunk()
        vim.bo.modifiable = false
      end,
      { desc = 'reset buffer' },
    },
    {
      'B',
      function()
        gitsigns.blame_line({ full = true })
      end,
      { desc = 'blame show full' },
    },
    { '/', gitsigns.show, { exit = true, desc = 'show base file' } },
    { 'g', cmd('LazyGit'), { exit = true, desc = 'lazygit', nowait = true } },
    { 'q', nil, { exit = true, nowait = true, desc = false } },
  },
})

local splits = require('smart-splits')

local window_hint = [[
^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
_h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
_b_: buffers ^^^^^^^^^^^    _f_: files  ^^    _w_: switch
]]

local windows = Hydra({
  name = 'Windows',
  hint = window_hint,
  config = {
    hint = {
      border = 'single',
    },
  },
  heads = {
    { 'h', '<c-w>h' },
    { 'j', '<c-w>j' },
    { 'k', '<c-w>k' },
    { 'l', '<c-w>l' },

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
    { 'b', cmd('Telescope buffers'), { exit = true } },
    { 'f', cmd('Telescope find_files'), { exit = true } },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local telescope = Hydra({
  name = 'Telescope',
  config = {
    color = 'blue',
  },
  heads = {
    { 'f', cmd('Telescope find_files'), { desc = 'files' } },
    { 'g', cmd('Telescope live_grep'), { desc = 'live grep' } },
    { 'h', cmd('Telescope help_tags'), { desc = 'vim help' } },
    { 'k', cmd('Telescope keymaps'), { desc = 'keymaps' } },
    { '/', cmd('Telescope current_buffer_fuzzy_find'), { desc = 'search in file' } },
    { '<enter>', cmd('Telescope'), { exit = true, desc = 'all pickers' } },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local hint = [[
_c_: continue   _b_: breakpoint  _i_: step into  _e_: eval
_t_: terminate  _s_: step over   _o_: step out   _q_: exit
]]

local debug = Hydra({
  name = 'Debug',
  hint = hint,
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'single',
    },
  },
  heads = {
    { 'q', nil, { exit = true, nowait = true } },
    { 'c', cmd('DapContinue'), { nowait = true } },
    { 't', cmd('DapTerminate'), { exit = true, nowait = true } },
    { 'b', cmd('DapToggleBreakpoint'), { nowait = true } },
    { 's', cmd('DapStepOver'), { nowait = true } },
    { 'i', cmd('DapStepInto'), { nowait = true } },
    { 'o', cmd('DapStepOut'), { nowait = true } },
    { 'e', cmd('DapEval'), { nowait = true } },
  },
})

local config = {
  buffers = buffers,
  git = git,
  windows = windows,
  telescope = telescope,
  dap = debug,
}

return config
