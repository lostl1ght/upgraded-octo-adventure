local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local Config = {}

local gitsigns = require('gitsigns')

local git_hint = [[
_K_: prev hunk      _s_: stage hunk        _d_: show deleted   _b_: blame line       _r_: reset hunk
_J_: next hunk      _u_: undo last stage   _p_: preview hunk   _B_: blame show full  _R_: reset buffer
^ ^                 _S_: stage buffer      ^ ^                 _/_: show base file
]]

Config.git = Hydra({
  name = 'GIT',
  hint = git_hint,
  config = {
    color = 'pink',
    hint = {
      border = 'single',
    },
    on_enter = function()
      pcmd('mkview', 'E32')
      vim.cmd('silent! %foldopen!')
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
    { 'R', gitsigns.reset_buffer, { desc = 'reset buffer' } },
    { 'r', gitsigns.reset_hunk, { desc = 'reset hunk' } },
    {
      'B',
      function()
        gitsigns.blame_line({ full = true })
      end,
      { desc = 'blame show full' },
    },
    { '/', gitsigns.show, { exit = true, nowait = true, desc = 'show base file' } },
    { 'q', nil, { exit = true, nowait = true, desc = false } },
  },
})

local tmux = require('tmux')

local window_hint = [[
^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<c-k>_   ^   _s_: horizontally
_h_ ^ ^ _l_  _H_ ^ ^ _L_   _<c-h>_ _<c-l>_   _v_: vertically
^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<c-j>_   ^   _c_: close
focus^^^^^^  window^^^^^^  ^_=_: equalize^   _w_: switch
_S_: swap ^  ^ ^^^^^^^ ^   ^^ ^          ^   _o_: remain only
_b_: buffers ^^^^^^^^^^^    _f_: files   ^
]]

Config.windows = Hydra({
  name = 'WINDOWS',
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
    { 'S', cmd('WinShift swap'), { exit = true } },

    { '<c-h>', tmux.resize_left },
    { '<c-j>', tmux.resize_bottom },
    { '<c-k>', tmux.resize_top },
    { '<c-l>', tmux.resize_right },
    { '=', '<c-w>=', { desc = 'equalize' } },

    { 's', pcmd('split', 'E36') },
    { 'v', pcmd('vsplit', 'E36') },
    { 'w', '<c-w>w', { exit = true } },
    { 'o', '<c-w>o', { exit = true, desc = 'remain only' } },
    { 'c', pcmd('close', 'E444') },
    { 'b', cmd('Telescope buffers'), { exit = true } },
    { 'f', cmd('Telescope find_files'), { exit = true } },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local telescope_hint = [[
_g_: grep _h_: help _k_: keymaps _/_: in file _<enter>_: all pickers
]]
Config.telescope = Hydra({
  name = 'TELESCOPE',
  hint = telescope_hint,
  config = {
    hint = {
      border = 'single',
    },
    color = 'blue',
  },
  heads = {
    {
      'g',
      function()
        vim.cmd('Telescope live_grep')
      end,
      { desc = 'live grep' },
    },
    {
      'h',
      function()
        vim.cmd('Telescope help_tags')
      end,
      { desc = 'vim help' },
    },
    {
      'k',
      function()
        vim.cmd('Telescope keymaps')
      end,
      { desc = 'keymaps' },
    },
    {
      '/',
      function()
        vim.cmd('Telescope current_buffer_fuzzy_find')
      end,
      { desc = 'search in file' },
    },
    {
      '<enter>',
      function()
        vim.cmd('Telescope')
      end,
      { exit = true, desc = 'all pickers' },
    },
    { 'q', nil, { exit = true, desc = false } },
  },
})

local debug_hint = [[
_c_: continue   _b_: breakpoint  _i_: step into  _e_: eval
_t_: terminate  _s_: step over   _o_: step out   _q_: exit
]]

Config.debug = Hydra({
  name = 'DEBUG',
  hint = debug_hint,
  config = {
    color = 'pink',
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

local session_hint = [[
_l_: last _L_: load _c_: dir _s_: save _d_: delete
]]

Config.session = Hydra({
  name = 'SESSIONS',
  hint = session_hint,
  config = {
    color = 'blue',
    hint = {
      border = 'single',
    },
  },
  heads = {
    { 'q', nil, { exit = true, desc = false } },
    { 'L', cmd('SessionManager load_session'), {} },
    { 'c', cmd('SessionManager load_current_dir_session'), {} },
    { 's', cmd('SessionManager save_current_session'), {} },
    { 'd', cmd('SessionManager delete_session'), {} },
    { 'l', cmd('SessionManager load_last_session'), {} },
  },
})

return Config
