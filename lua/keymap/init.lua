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
  { 'Q', 'q', opts('Record macro') },
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
  { ']b', '<Plug>(CybuNext)', opts('Next buffer') },
  { '[b', '<Plug>(CybuPrev)', opts('Previous buffer') },
  -- +---------+
  -- + Windows +
  -- +---------+
  { '<c-l>', require('tmux').move_right, opts('Right window') },
  { '<c-k>', require('tmux').move_top, opts('Upper window') },
  { '<c-j>', require('tmux').move_bottom, opts('Lower windwo') },
  { '<c-h>', require('tmux').move_left, opts('Left window') },
  { '<m-l>', require('tmux').resize_right, opts('Resize right window') },
  { '<m-k>', require('tmux').resize_top, opts('Resize upper window') },
  { '<m-j>', require('tmux').resize_bottom, opts('Resize lower windwo') },
  { '<m-h>', require('tmux').resize_left, opts('Resize left window') },
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
  { 'gr', vim.lsp.buf.rename, opts('Rename') },
  { ']e', vim.diagnostic.goto_next, opts('Next diagnostic') },
  { '[e', vim.diagnostic.goto_prev, opts('Next diagnostic') },
  { 'gl', '<plug>(ToggleDiagnostics)', opts('Toggle diagnostics') },
  { 'gf', '<plug>(LspFormat)', opts('Format') }, -- Not displayed
  { 'ge', cmd('TroubleToggle lsp_references'), opts('References') }, -- Not displayed
  { 'gi', cmd('TroubleToggle lsp_implementations'), opts('Implementations') }, -- Not displayed
  { 'gd', cmd('TroubleToggle lsp_definitions'), opts('Definitions') },
  { 'gy', cmd('TroubleToggle lsp_type_definitions'), opts('Type definitions') },
  { 'gw', cmd('TroubleToggle document_diagnostics'), opts('Document diagnostics') },
  { 'gW', cmd('TroubleToggle workspace_diagnostics'), opts('Workspace diagnostics') },
  { 'gs', cmd('AerialToggle'), opts('Document symbols') },
  { 'ga', cmd('CodeActionMenu'), opts('Code actions') },
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
  { '<leader>Gs', require('gitsigns').stage_hunk, opts('Stage hunk') },
  { '<leader>Gu', require('gitsigns').undo_stage_hunk, opts('Undo last stage') },
  { '<leader>GS', require('gitsigns').stage_buffer, opts('Stage buffer') },
  { '<leader>Gp', require('gitsigns').preview_hunk, opts('Preview hunk') },
  { '<leader>Gd', require('gitsigns').toggle_deleted, opts('Toggle deleted') },
  { '<leader>Gb', require('gitsigns').blame_line, opts('Blame line') },
  { '<leader>GR', require('gitsigns').reset_buffer, opts('Reset buffer') },
  { '<leader>Gr', require('gitsigns').reset_hunk, opts('Reset hunk') },
  {
    '<leader>GB',
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
  { '<leader>qs', require('persistence').load, opts('Load current directory') },
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
  { '<leader>b', cmd('Telescope buffers'), opts('Buffers') },
  { '<leader>e', cmd('LfToggle'), opts('File manager') },
  { '<leader>g', cmd('Lazygit'), opts('Lazygit') },
})
