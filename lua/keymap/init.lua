require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local noremap = key.noremap
local opts = key.new_opts
local cmd = key.cmd

nmap({
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap) },
  { '<Leader>ps', cmd('PackerSync'), opts(noremap) },
  { '<Leader>pS', cmd('PackerStatus'), opts(noremap) },
})

nmap({
  {
    '<leader>b',
    function()
      if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
        require('modules.ui.hydra.buffer'):activate()
      end
    end,
    opts(noremap),
  },
  {
    '<leader>w',
    function()
      require('modules.ui.hydra.window'):activate()
    end,
    opts(noremap),
  },
})

nmap({
  { 'gd', cmd('Lspsaga lsp_finder'), opts(noremap, 'LSP: goto definition') },
  { 'gr', cmd('Lspsaga rename'), opts(noremap, 'LSP: rename') },
  { 'ga', cmd('Lspsaga code_action'), opts(noremap, 'LSP: code action') },
  { 'gp', cmd('Lspsaga preview_definition'), opts(noremap, 'LSP: preview definition') },
  { 'K', cmd('Lspsaga hover_doc'), opts(noremap, 'LSP: hover') },
})
