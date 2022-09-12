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
    '<leader>l',
    function()
      require('modules.ui.hydra').lsp:activate()
    end,
    opts('Hydra: lsp'),
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
  { 'gd', cmd('Lspsaga lsp_finder'), opts('Lsp: goto definition') },
  { 'gr', cmd('Lspsaga rename'), opts('Lsp: rename') },
  { 'ga', cmd('Lspsaga code_action'), opts('Lsp: code action') },
  { 'gp', cmd('Lspsaga peek_definition'), opts('Lsp: preview definition') },
  { 'K', cmd('Lspsaga hover_doc'), opts('Lsp: hover') },
  {
    'gf',
    function()
      lsp.lsp_formatting(0)
    end,
    opts('Lsp: format'),
  },
})

nmap({ '<leader>e', cmd('RnvimrToggle'), opts('Ranger') })

nmap({
  { '<c-l>', '<c-w>l', opts('Nvim: move left') },
  { '<c-h>', '<c-w>h', opts('Nvim: move right') },
  { '<c-j>', '<c-w>j', opts('Nvim: move down') },
  { '<c-k>', '<c-w>k', opts('Nvim: move up') },
})
