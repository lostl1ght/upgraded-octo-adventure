require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local opts = key.new_opts
local cmd = key.cmd

nmap({
  { '<Leader>pu', cmd('PackerUpdate'), opts('Packer: update') },
  { '<Leader>pi', cmd('PackerInstall'), opts('Packer: install') },
  { '<Leader>pc', cmd('PackerCompile'), opts('Packer: compile') },
  { '<Leader>ps', cmd('PackerSync'), opts('Packer: sync') },
  { '<Leader>pS', cmd('PackerStatus'), opts('Packer: status') },
})

nmap({
  { 'gr', vim.lsp.buf.rename, opts('Lsp: rename') },
  { 'gd', cmd('TroubleToggle lsp_definitions'), opts('Lsp: definitions') },
  { 'ge', cmd('TroubleToggle lsp_references'), opts('Lsp: references') },
  { 'gy', cmd('TroubleToggle lsp_type_definitions'), opts('Lsp: type definitions') },
  { 'gi', cmd('TroubleToggle lsp_implementations'), opts('Lsp: type definitions') },
  { 'gw', cmd('TroubleToggle document_diagnostics'), opts('Lsp: document diagnostics') },
  { 'gW', cmd('TroubleToggle workspace_diagnostics'), opts('Lsp: workspace diagnostics') },
  { 'K', vim.lsp.buf.hover, opts('Lsp: hover') },
  {
    'gf',
    function()
      require('modules.lsp.lspconfig').lsp_formatting(0)
    end,
    opts('Lsp: format'),
  },
  { 'gs', cmd('SymbolsOutline'), opts('Lsp: document symbols') },
  {
    'gl',
    function()
      require('lsp_lines').toggle()
      vim.g.lsplines_enabled = not vim.g.lsplines_enabled
      vim.notify(
        string.format('Line diagnostics %s', vim.g.lsplines_enabled and 'enabled' or 'disabled')
      )
    end,
    opts('Lsp: toggle diagnostics'),
  },
  { 'ga', cmd('CodeActionMenu'), opts('Lsp: code actions') },
})

nmap({ '<leader>e', cmd('RnvimrToggle'), opts('Ranger') })

nmap({
  { '<leader>f', cmd('Telescope find_files'), opts('Telescope: files') },
  { '<leader>b', cmd('Telescope buffers'), opts('Telescope: buffers') },
})

nmap({
  {
    '<leader>g',
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
      vim.cmd('bn')
    end,
    opts('Hydra: buffers'),
  },
  {
    '[b',
    function()
      require('modules.ui.hydra').buffers:activate()
      vim.cmd('bp')
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
  {
    '<leader>t',
    function()
      require('modules.ui.hydra').telescope:activate()
    end,
    opts('Hydra: telescope'),
  },
})
