require('keymap.config')
local key = require('core.keymap')
local nmap, xmap = key.nmap, key.xmap
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
  {
    '<leader>b',
    function()
      require('modules.ui.hydra').buffers:activate()
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
    '<leader>g',
    function()
      require('modules.ui.hydra').git:activate()
    end,
    opts('Hydra: git'),
  },
  {
    '<leader>f',
    function()
      require('modules.ui.hydra').telescope:activate()
    end,
    opts('Hydra: telescope'),
  },
  {
    '<leader>d',
    function()
      require('modules.ui.hydra').dap:activate()
    end,
    opts('Hydra: debug'),
  },
})

xmap({
  '<leader>g',
  function()
    require('modules.ui.hydra').git:activate()
  end,
  opts('Hydra: git'),
})

local lsp = require('modules.lsp.lspconfig')
nmap({
  { 'gr', vim.lsp.buf.rename, opts('Lsp: rename') },
  { 'gd', cmd('TroubleToggle lsp_definitions'), opts('Lsp: definitions') },
  { 'ge', cmd('TroubleToggle lsp_references'), opts('Lsp: references') },
  { 'gt', cmd('TroubleToggle lsp_type_definitions'), opts('Lsp: type definitions') },
  { 'gi', cmd('TroubleToggle lsp_implementations'), opts('Lsp: type definitions') },
  { 'gw', cmd('TroubleToggle document_diagnostics'), opts('Lsp: document diagnostics') },
  { 'gW', cmd('TroubleToggle workspace_diagnostics'), opts('Lsp: workspace diagnostics') },
  { 'K', vim.lsp.buf.hover, opts('Lsp: hover') },
  {
    'gf',
    function()
      lsp.lsp_formatting(0)
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
})

nmap({ '<leader>e', cmd('RnvimrToggle'), opts('Ranger') })

nmap({
  { '<c-l>', '<c-w>l', opts('Nvim: move left') },
  { '<c-h>', '<c-w>h', opts('Nvim: move right') },
  { '<c-j>', '<c-w>j', opts('Nvim: move down') },
  { '<c-k>', '<c-w>k', opts('Nvim: move up') },
})
