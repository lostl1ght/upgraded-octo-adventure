local keymap = require('core.keymap')
local nmap, imap, tmap, xmap = keymap.nmap, keymap.imap, keymap.tmap, keymap.xmap
local opts = keymap.new_opts
local cmd = keymap.cmd
local remap = keymap.remap

vim.g.mapleader = ' '

xmap({ ' ', '' })

imap({
  { 'ii', '<esc>' },
  { '<f1>', '', opts(remap) },
})

tmap({ 'ii', '<c-\\><c-n>' })

nmap({
  { ' ', '' },
  { '<f1>', '', opts(remap) },
  {
    '<leader>h',
    function()
      vim.api.nvim_cmd({ cmd = 'nohlsearch' }, {})
    end,
    opts('Basic: no highlight'),
  },
  {
    '<leader>s',
    function()
      vim.api.nvim_cmd({ cmd = 'write' }, {})
    end,
    opts('Basic: save'),
  },
  {
    '<leader>`',
    function()
      vim.api.nvim_cmd({ cmd = 'buffer', args = { '#' } }, {})
    end,
    opts('Buffer: switch'),
  },
  { 'Q', 'q', opts('Macro') },
  { 'q', '', opts(remap) },
  { '<c-l>', '<c-w>l', opts('Window: right') },
  { '<c-k>', '<c-w>k', opts('Window: up') },
  { '<c-j>', '<c-w>j', opts('Window: down') },
  { '<c-h>', '<c-w>h', opts('Window: left') },
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
    opts('Buffer: close'),
  },
  {
    '<leader>C',
    function()
      vim.api.nvim_cmd({ cmd = 'bdelete', bang = true }, {})
    end,
    opts('Buffer: force close'),
  },
  { '<Leader>pu', cmd('PackerUpdate'), opts('Packer: update') },
  { '<Leader>pi', cmd('PackerInstall'), opts('Packer: install') },
  { '<Leader>pc', cmd('PackerCompile'), opts('Packer: compile') },
  { '<Leader>ps', cmd('PackerSync'), opts('Packer: sync') },
  { '<Leader>pS', cmd('PackerStatus'), opts('Packer: status') },
  { 'gr', vim.lsp.buf.rename, opts('Lsp: rename') },
  { 'gd', cmd('TroubleToggle lsp_definitions'), opts('Lsp: definitions') },
  { 'ge', cmd('TroubleToggle lsp_references'), opts('Lsp: references') },
  { 'gy', cmd('TroubleToggle lsp_type_definitions'), opts('Lsp: type definitions') },
  { 'gi', cmd('TroubleToggle lsp_implementations'), opts('Lsp: type definitions') },
  { 'gw', cmd('TroubleToggle document_diagnostics'), opts('Lsp: document diagnostics') },
  { 'gW', cmd('TroubleToggle workspace_diagnostics'), opts('Lsp: workspace diagnostics') },
  { 'K', vim.lsp.buf.hover, opts('Lsp: hover') },
  { 'gf', cmd('LspFormat'), opts('Lsp: format') },
  { 'gs', cmd('AerialToggle'), opts('Lsp: document symbols') },
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
    opts('Lsp: toggle diagnostics'),
  },
  { 'ga', cmd('CodeActionMenu'), opts('Lsp: code actions') },
  { '<leader>f', cmd('Telescope find_files'), opts('Telescope: files') },
  { '<leader>b', cmd('Telescope buffers'), opts('Telescope: buffers') },
  { '<leader>e', cmd('LfToggle'), opts('Lf') },
  { '<leader>g', cmd('Lazygit'), opts('Lazygit') },
  {
    '<leader>G',
    function()
      require('modules.ui.hydra').git:activate()
    end,
    opts('Hydra: git'),
  },
  {
    '<leader>t',
    function()
      require('modules.ui.hydra').telescope:activate()
    end,
    opts('Hydra: telescope'),
  },
  {
    ']b',
    function()
      require('modules.ui.hydra').buffers:activate()
      vim.api.nvim_cmd({ cmd = 'bnext' }, {})
    end,
    opts('Hydra: buffers'),
  },
  {
    '[b',
    function()
      require('modules.ui.hydra').buffers:activate()
      vim.api.nvim_cmd({ cmd = 'bprevious' }, {})
    end,
    opts('Hydra: buffers'),
  },
  {
    '<leader>w',
    function()
      require('modules.ui.hydra').windows:activate()
    end,
    opts('Hydra: windows'),
  },
  { ']b', '<Plug>(CybuNext)', opts('Buffer: next') },
  { '[b', '<Plug>(CybuPrev)', opts('Buffer: prev') },
})
