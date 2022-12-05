local uv, api = vim.loop, vim.api
local vim_path = vim.fn.stdpath('config')
local data_dir = vim.fn.stdpath('data') .. '/site/'
local modules_dir = vim_path .. '/lua/modules'
local packer_compiled = data_dir .. 'lua/packer_compiled.lua'

local Packer = {}

local function get_list()
  local list = {}
  local tmp = vim.fs.find('plugins.lua', { path = modules_dir, type = 'file', limit = math.huge })
  for _, f in ipairs(tmp) do
    table.insert(list, string.match(f, 'lua/(.+).lua$'))
  end
  return list
end

function Packer:load_plugins()
  self.repos = {
    { 'wbthomason/packer.nvim' },
    { 'lewis6991/impatient.nvim' },
  }

  local plugins_file = get_list()
  for _, m in ipairs(plugins_file) do
    require(m)
  end
end

function Packer:load_packer()
  self:load_plugins()
  require('packer').startup({
    self.repos,
    config = {
      compile_path = packer_compiled,
      git = { clone_timeout = 120 },
      display = { open_cmd = 'topleft 65vnew \\[packer\\]' },
    },
  })
end

function Packer:bootstrap()
  local packer_dir = data_dir .. 'pack/packer/start/packer.nvim'
  if not uv.fs_stat(packer_dir) then
    api.nvim_cmd({
      cmd = '!',
      args = {
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        packer_dir,
      },
    }, {})
    uv.fs_mkdir(data_dir .. 'lua', 511, function()
      assert('make compile path dir faield')
    end)
    vim.cmd.packadd('packer.nvim')
    self:load_packer()
    require('packer').sync()
    return true
  end
  return false
end

function Packer:init()
  if not Packer:bootstrap() then
    self:load_packer()
  end
end

local plugins = {}

function plugins.init()
  Packer:init()

  if vim.fn.filereadable(packer_compiled) == 1 then
    require('packer_compiled')
  else
    vim.notify('Run PackerSync or PackerCompile', vim.log.levels.WARN, { title = 'Packer' })
  end
  local PackerHooks = vim.api.nvim_create_augroup('PackerHooks', {})
  vim.api.nvim_create_autocmd('User', {
    pattern = 'PackerCompileDone',
    callback = function()
      vim.notify('compile done', vim.log.levels.INFO, { title = 'Packer' })
    end,
    group = PackerHooks,
  })
end

function plugins.register_plugin(repo)
  table.insert(Packer.repos, repo)
end

return plugins
