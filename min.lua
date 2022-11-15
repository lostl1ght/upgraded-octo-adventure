vim.o.runtimepath = '$VIMRUNTIME'
vim.o.packpath = '/tmp/nvim/site'
local package_root = '/tmp/nvim/site/pack'
local install_path = package_root .. '/packer/start/packer.nvim'
local function load_plugins()
  require('packer').startup({
    {
      { 'wbthomason/packer.nvim' },
      { 'rebelot/kanagawa.nvim' },
      -- plugins
    },
    config = {
      package_root = package_root,
      compile_path = install_path .. '/plugin/packer_compiled.lua',
    },
  })
end
local function load_config()
  vim.opt.termguicolors = true
  vim.cmd.colorscheme('kanagawa')
  -- config
end
if vim.fn.isdirectory(install_path) == 0 then
  print('Installing dependencies.')
  vim.fn.system({
    'git',
    'clone',
    '--depth=1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
end
load_plugins()
require('packer').sync()
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackerComplete',
  once = true,
  callback = function()
    load_config()
    print('Ready')
  end,
})
