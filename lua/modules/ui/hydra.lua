local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local buffers_hint = [[
_[_: prev _]_: next _c_: close _C_: force close
]]
local buffers = Hydra({
  name = 'BUFFERS',
  hint = buffers_hint,
  config = {
    hint = {
      border = 'single',
    },
  },
  heads = {
    { ']', cmd('bn'), { desc = 'next buf' } },
    { '[', cmd('bp'), { desc = 'prev buf' } },
    {
      'c',
      function()
        if not vim.o.modified then
          vim.cmd('bd')
        end
      end,
      { desc = 'close' },
    },
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
_S_: swap ^  ^ ^^^^^^^ ^   ^^ ^          ^   _o_: remain only
_b_: buffers ^^^^^^^^^^^    _f_: files   ^   _w_: switch
]]

local windows = Hydra({
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

local telescope_hint = [[
_g_: grep _h_: help _k_: keymaps _/_: in file _<enter>_: all pickers
]]
local telescope = Hydra({
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

local debug = Hydra({
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

local session = Hydra({
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
    { 'c', cmd('SessionManager load_currend_dir_session'), {} },
    { 's', cmd('SessionManager save_current_session'), {} },
    { 'd', cmd('SessionManager delete_session'), {} },
    { 'l', cmd('SessionManager load_last_session'), {} },
  },
})

local config = {
  buffers = buffers,
  git = git,
  windows = windows,
  telescope = telescope,
  dap = debug,
  session = session,
}

return config
