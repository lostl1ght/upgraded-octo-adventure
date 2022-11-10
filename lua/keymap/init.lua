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
  { ']b', '<Plug>(CybuNext)', opts('Next buffer') },
  { '[b', '<Plug>(CybuPrev)', opts('Previous buffer') },
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
    opts('Lower windwo'),
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
    opts('Resize lower windwo'),
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
  { 'K', vim.lsp.buf.hover, opts('Hover') },
  { 'gr', vim.lsp.buf.rename, opts('Rename') },
  { 'gd', cmd('TroubleToggle lsp_definitions'), opts('Definitions') },
  { 'ge', cmd('TroubleToggle lsp_references'), opts('References') },
  { 'gy', cmd('TroubleToggle lsp_type_definitions'), opts('Type definitions') },
  { 'gi', cmd('TroubleToggle lsp_implementations'), opts('Type definitions') },
  { 'gw', cmd('TroubleToggle document_diagnostics'), opts('Document diagnostics') },
  { 'gW', cmd('TroubleToggle workspace_diagnostics'), opts('Workspace diagnostics') },
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
  { 'gf', '<plug>(LspFormat)', opts('Format') },
  { 'gs', cmd('AerialToggle'), opts('Document symbols') },
  {
    'gl',
    function()
      vim.g.lsplines_enabled = not vim.g.lsplines_enabled
      vim.diagnostic.config({
        virtual_lines = vim.g.lsplines_enabled,
      })
      vim.notify(
        string.format('Line diagnostics %s', vim.g.lsplines_enabled and 'enabled' or 'disabled')
      )
    end,
    opts('Toggle diagnostics'),
  },
  { 'ga', cmd('CodeActionMenu'), opts('Code actions') },
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
    '<leader>Gs',
    function()
      require('gitsigns').stage_hunk()
    end,
    opts('Stage hunk'),
  },
  {
    '<leader>Gu',
    function()
      require('gitsigns').undo_stage_hunk()
    end,
    opts('Undo last stage'),
  },
  {
    '<leader>GS',
    function()
      require('gitsigns').stage_buffer()
    end,
    opts('Stage buffer'),
  },
  {
    '<leader>Gp',
    function()
      require('gitsigns').preview_hunk()
    end,
    opts('Preview hunk'),
  },
  {
    '<leader>Gd',
    function()
      require('gitsigns').toggle_deleted()
    end,
    opts('Toggle deleted'),
  },
  {
    '<leader>Gb',
    function()
      require('gitsigns').blame_line()
    end,
    opts('Blame line'),
  },
  {
    '<leader>GR',
    function()
      require('gitsigns').reset_buffer()
    end,
    opts('Reset buffer'),
  },
  {
    '<leader>Gr',
    function()
      require('gitsigns').reset_hunk()
    end,
    opts('Reset hunk'),
  },
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
  -- +-------+
  -- + Tools +
  -- +-------+
  { '<leader>f', cmd('Telescope find_files'), opts('Files') },
  { '<leader>b', cmd('Telescope buffers'), opts('Buffers') },
  { '<leader>e', cmd('LfToggle'), opts('File manager') },
  { '<leader>g', cmd('Lazygit'), opts('Lazygit') },
})
