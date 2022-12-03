local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local cmd = keymap.cmd
local remap, expr = keymap.remap, keymap.expr

vim.g.mapleader = ' '

xmap({ ' ', '' })

imap({
  { 'ii', '<esc>' },
  { '<f1>', '', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })

nmap({
  -- +-------+
  -- + Basic +
  -- +-------+
  { ' ', '' },
  { '<f1>', '', opts(remap) },
  { 'Q', 'q', opts('Macro') },
  { 'q', '', opts(remap) },
  {
    '<leader>h',
    function()
      vim.api.nvim_cmd({ cmd = 'nohlsearch' }, {})
    end,
    opts('No highlight'),
  },
  {
    '<leader>s',
    function()
      vim.api.nvim_cmd({ cmd = 'write', mods = { silent = true } }, {})
    end,
    opts('Write buffer'),
  },
  -- +---------+
  -- + Buffers +
  -- +---------+
  {
    '<leader>`',
    function()
      vim.api.nvim_cmd({ cmd = 'buffer', args = { '#' } }, {})
    end,
    opts('Switch buffer'),
  },
  {
    '<leader>c',
    function()
      if vim.o.modified then
        vim.notify('Save before closing')
      elseif vim.o.buftype == 'terminal' then
        vim.notify('Kill the terminal')
      else
        vim.api.nvim_cmd({ cmd = 'bdelete' }, {})
      end
    end,
    opts('Close buffer'),
  },
  {
    '<leader>C',
    function()
      vim.api.nvim_cmd({ cmd = 'bdelete', bang = true }, {})
    end,
    opts('Force close buffer'),
  },
  {
    '<plug>(ReachBuffers)',
    function()
      require('reach').buffers({
        show_current = true,
        modified_icon = '●',
        force_delete = { 'terminal' },
      })
    end,
    opts(),
  },
  { '<leader>b', '<plug>(ReachBuffers)', opts('Buffers') },
  -- +---------+
  -- + Windows +
  -- +---------+
  {
    '<c-l>',
    function()
      require('tmux').move_right()
    end,
    opts('Right window'),
  },
  {
    '<c-k>',
    function()
      require('tmux').move_top()
    end,
    opts('Upper window'),
  },
  {
    '<c-j>',
    function()
      require('tmux').move_bottom()
    end,
    opts('Lower window'),
  },
  {
    '<c-h>',
    function()
      require('tmux').move_left()
    end,
    opts('Left window'),
  },
  {
    '<m-l>',
    function()
      require('tmux').resize_right()
    end,
    opts('Resize right window'),
  },
  {
    '<m-k>',
    function()
      require('tmux').resize_top()
    end,
    opts('Resize upper window'),
  },
  {
    '<m-j>',
    function()
      require('tmux').resize_bottom()
    end,
    opts('Resize lower window'),
  },
  {
    '<m-h>',
    function()
      require('tmux').resize_left()
    end,
    opts('Resize left window'),
  },
  { '<leader>w=', '<c-w>=', opts('Equalize') },
  { '<leader>ws', cmd('split'), opts('Split horizontaly') },
  { '<leader>wv', cmd('vsplit'), opts('Split vertically') },
  { '<leader>wS', cmd('WinShift swap'), opts('Swap window') },
  { '<leader>wo', '<c-w>o', opts('Remain only') },
  {
    '<leader>wc',
    function()
      pcall(vim.api.nvim_cmd, { cmd = 'close' }, {})
    end,
    opts('Close'),
  },
  -- +--------+
  -- + Packer +
  -- +--------+
  { '<Leader>pu', cmd('PackerUpdate'), opts('Update') },
  { '<Leader>pi', cmd('PackerInstall'), opts('Install') },
  { '<Leader>pc', cmd('PackerCompile'), opts('Compile') },
  { '<Leader>ps', cmd('PackerSync'), opts('Sync') },
  { '<Leader>pS', cmd('PackerStatus'), opts('Status') },
  -- +-----+
  -- + LSP +
  -- +-----+
  {
    '<plug>(LspFormat)',
    function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == 'null-ls'
        end,
      })
      pcall(vim.api.nvim_cmd, { cmd = 'write', mods = { silent = true } }, {})
    end,
    opts(),
  },
  {
    '<plug>(ToggleDiagnostics)',
    function()
      vim.g.lsplines_enabled = not vim.g.lsplines_enabled
      vim.diagnostic.config({
        virtual_lines = vim.g.lsplines_enabled,
      })
      vim.notify(
        string.format('Line diagnostics %s', vim.g.lsplines_enabled and 'enabled' or 'disabled')
      )
    end,
    opts(),
  },
  { 'K', vim.lsp.buf.hover, opts('Hover') },
  { ']d', vim.diagnostic.goto_next, opts('Next diagnostic') },
  { '[d', vim.diagnostic.goto_prev, opts('Next diagnostic') },
  { '<leader>lr', vim.lsp.buf.rename, opts('Rename') },
  { '<leader>ll', '<plug>(ToggleDiagnostics)', opts('Toggle diagnostics') },
  { '<leader>lf', '<plug>(LspFormat)', opts('Format') },
  { '<leader>le', cmd('Glance references'), opts('References') },
  { '<leader>li', cmd('Glance implementations'), opts('Implementations') },
  { '<leader>ld', cmd('Glance definitions'), opts('Definitions') },
  { '<leader>ly', cmd('Glance type_definitions'), opts('Type definitions') },
  { '<leader>lw', cmd('TroubleToggle document_diagnostics'), opts('Document diagnostics') },
  { '<leader>lW', cmd('TroubleToggle workspace_diagnostics'), opts('Workspace diagnostics') },
  { '<leader>ls', cmd('AerialToggle'), opts('Document symbols') },
  { '<leader>la', cmd('CodeActionMenu'), opts('Code actions') },
  {
    '<c-d>',
    function()
      if not require('noice.lsp').scroll(4) then
        return '<c-d>'
      end
    end,
    opts(expr, 'Scroll down'),
  },
  {
    '<c-u>',
    function()
      if not require('noice.lsp').scroll(-4) then
        return '<c-u>'
      end
    end,
    opts(expr, 'Scroll up'),
  },
  -- +-----+
  -- + Git +
  -- +-----+
  {
    ']h',
    function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        require('gitsigns').next_hunk()
      end)
      return '<Ignore>'
    end,
    opts(expr, 'Next hunk'),
  },
  {
    '[h',
    function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        require('gitsigns').prev_hunk()
      end)
      return '<Ignore>'
    end,
    opts(expr, 'Previous hunk'),
  },
  {
    '<leader>gs',
    function()
      require('gitsigns').stage_hunk()
    end,
    opts('Stage hunk'),
  },
  {
    '<leader>gu',
    function()
      require('gitsigns').undo_stage_hunk()
    end,
    opts('Undo last stage'),
  },
  {
    '<leader>gS',
    function()
      require('gitsigns').stage_buffer()
    end,
    opts('Stage buffer'),
  },
  {
    '<leader>gp',
    function()
      require('gitsigns').preview_hunk()
    end,
    opts('Preview hunk'),
  },
  {
    '<leader>gd',
    function()
      require('gitsigns').toggle_deleted()
    end,
    opts('Toggle deleted'),
  },
  {
    '<leader>gb',
    function()
      require('gitsigns').blame_line()
    end,
    opts('Blame line'),
  },
  {
    '<leader>gR',
    function()
      require('gitsigns').reset_buffer()
    end,
    opts('Reset buffer'),
  },
  {
    '<leader>gr',
    function()
      require('gitsigns').reset_hunk()
    end,
    opts('Reset hunk'),
  },
  {
    '<leader>gB',
    function()
      require('gitsigns').blame_line({ full = true })
    end,
    opts('Blame show full'),
  },
  -- +-----------+
  -- + Telescope +
  -- +-----------+
  { '<leader>tg', cmd('Telescope live_grep'), opts('Live grep') },
  { '<leader>th', cmd('Telescope help_tags'), opts('Vim help') },
  { '<leader>t<enter>', cmd('Telescope'), opts('All pickers') },
  -- +-------+
  -- + Debug +
  -- +-------+
  { '<leader>dc', cmd('DapContinue'), opts('Continue') },
  { '<leader>dt', cmd('DapTerminate'), opts('Terminate') },
  { '<leader>db', cmd('DapToggleBreakpoint'), opts('Breakpoint') },
  { '<leader>ds', cmd('DapStepOver'), opts('Step over') },
  { '<leader>di', cmd('DapStepInto'), opts('Step into') },
  { '<leader>do', cmd('DapStepOut'), opts('Step out') },
  { '<leader>de', cmd('DapEval'), opts('Evaluate') },
  -- +-------------+
  -- + Persistence +
  -- +-------------+
  {
    '<leader>qs',
    function()
      require('persistence').load()
    end,
    opts('Load current directory'),
  },
  {
    '<leader>ql',
    function()
      require('persistence').load({ last = true })
    end,
    opts('Load last'),
  },
  {
    '<leader>qd',
    function()
      require('persistence').stop()
      vim.notify('stopped', vim.log.levels.INFO, { title = 'Persistence' })
    end,
    opts('Stop'),
  },
  {
    '<leader>qD',
    function()
      require('persistence').start()
      vim.notify('started', vim.log.levels.INFO, { title = 'Persistence' })
    end,
    opts('Start'),
  },
  -- +-------+
  -- + Tools +
  -- +-------+
  { '<leader>f', cmd('Telescope find_files'), opts('Files') },
  {
    '<leader>e',
    function()
      require('lir.float').toggle(vim.loop.cwd())
    end,
    opts('File manager'),
  },
})
