local Hydra = require('hydra')
local gitsigns = require('gitsigns')

local hint = [[
_K_: prev hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line       _r_: reset hunk
_J_: next hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full  _R_: reset buffer
_g_: neogit      _S_: stage buffer      ^ ^                 _/_: show base file
_q_: exit
]]

local hydra = Hydra({
  name = 'Git',
  hint = hint,
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

return hydra
