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

nmap({
  {
    '<leader>b',
    function()
      if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
        require('modules.ui.hydra').buffers:activate()
      end
    end,
    opts(noremap, 'Hydra: buffers'),
  },
  {
    '<leader>w',
    function()
      require('modules.ui.hydra').windows:activate()
    end,
    opts(noremap, 'Hydra: windows'),
  },
  {
    '<leader>l',
    function()
      require('modules.ui.hydra').lsp:activate()
    end,
    opts(noremap, 'Hydra: lsp'),
  },
  {
    '<leader>g',
    function()
      require('modules.ui.hydra').git:activate()
    end,
    opts(noremap, 'Hydra: git'),
  },
})

xmap({
  '<leader>g',
  function()
    require('modules.ui.hydra').git:activate()
  end,
  opts(noremap, 'Hydra: git'),
})

nmap({
  { 'gd', cmd('Lspsaga lsp_finder'), opts(noremap, 'LSP: goto definition') },
  { 'gr', cmd('Lspsaga rename'), opts(noremap, 'LSP: rename') },
  { 'ga', cmd('Lspsaga code_action'), opts(noremap, 'LSP: code action') },
  { 'gp', cmd('Lspsaga preview_definition'), opts(noremap, 'LSP: preview definition') },
  { 'K', cmd('Lspsaga hover_doc'), opts(noremap, 'LSP: hover') },
  {
    'gf',
    function()
      require('modules.lsp.lspconfig').lsp_formatting(0)
    end,
    opts(noremap, 'Lsp: format'),
  },
})

nmap({ '<leader>e', cmd('NvimTreeToggle'), opts(noremap, 'Nvim tree') })
