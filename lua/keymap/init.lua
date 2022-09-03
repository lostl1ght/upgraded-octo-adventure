require('keymap.config')
local key = require('core.keymap')
local nmap, xmap = key.nmap, key.xmap
local noremap = key.noremap
local opts = key.new_opts
local cmd = key.cmd

nmap({
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, 'Packer: update') },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, 'Packer: install') },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, 'Packer: compile') },
  { '<Leader>ps', cmd('PackerSync'), opts(noremap, 'Packer: sync') },
  { '<Leader>pS', cmd('PackerStatus'), opts(noremap, 'Packer: status') },
})

local hydra = require('modules.ui.hydra')
nmap({
  {
    '<leader>b',
    function()
      hydra.buffers:activate()
    end,
    opts(noremap, 'Hydra: buffers'),
  },
  {
    '<leader>w',
    function()
      hydra.windows:activate()
    end,
    opts(noremap, 'Hydra: windows'),
  },
  {
    '<leader>l',
    function()
      hydra.lsp:activate()
    end,
    opts(noremap, 'Hydra: lsp'),
  },
  {
    '<leader>g',
    function()
      hydra.git:activate()
    end,
    opts(noremap, 'Hydra: git'),
  },
  {
    '<leader>f',
    function()
      hydra.telescope:activate()
    end,
    opts(noremap, 'Hydra: telescope'),
  },
  {
    '<leader>d',
    function()
      hydra.dap:activate()
    end,
    opts(noremap, 'Hydra: debug'),
  },
})

xmap({
  '<leader>g',
  function()
    hydra.git:activate()
  end,
  opts(noremap, 'Hydra: git'),
})

local lsp = require('modules.lsp.lspconfig')
nmap({
  { 'gd', cmd('Lspsaga lsp_finder'), opts(noremap, 'Lsp: goto definition') },
  { 'gr', cmd('Lspsaga rename'), opts(noremap, 'Lsp: rename') },
  { 'ga', cmd('Lspsaga code_action'), opts(noremap, 'Lsp: code action') },
  { 'gp', cmd('Lspsaga preview_definition'), opts(noremap, 'Lsp: preview definition') },
  { 'K', cmd('Lspsaga hover_doc'), opts(noremap, 'Lsp: hover') },
  {
    'gf',
    function()
      lsp.lsp_formatting(0)
    end,
    opts(noremap, 'Lsp: format'),
  },
})

nmap({ '<leader>e', cmd('NvimTreeToggle'), opts(noremap, 'Nvim tree') })

nmap({
  { '<c-l>', '<c-w>l', opts(noremap, 'Nvim: move left') },
  { '<c-h>', '<c-w>h', opts(noremap, 'Nvim: move right') },
  { '<c-j>', '<c-w>j', opts(noremap, 'Nvim: move down') },
  { '<c-k>', '<c-w>k', opts(noremap, 'Nvim: move up') },
})
