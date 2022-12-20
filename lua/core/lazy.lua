local uv, api = vim.loop, vim.api
local data_dir = vim.fn.stdpath('data')
local vim_path = vim.fn.stdpath('config')
local modules_dir = vim_path .. '/lua/modules'

local Lazy = {}

local function get_list()
  local list = {}
  local tmp = vim.fs.find('plugins.lua', { path = modules_dir, type = 'file', limit = math.huge })
  for _, f in ipairs(tmp) do
    table.insert(list, string.match(f, 'lua/(.+).lua$'))
  end
  return list
end

function Lazy:load_plugins()
  self.repos = {
    { 'lewis6991/impatient.nvim', lazy = false },
  }

  local plugins_file = get_list()
  for _, m in ipairs(plugins_file) do
    require(m)
  end
end
function Lazy:load_lazy()
  self:load_plugins()
  require('lazy').setup(self.repos, {
    defaults = {
      lazy = true,
    },
    dev = {
      path = '~/dev/plugins',
    },
  })
end

function Lazy:bootstrap()
  local lazy_path = data_dir .. '/lazy/lazy.nvim'
  if not uv.fs_stat(lazy_path) then
    api.nvim_cmd({
      cmd = '!',
      args = {
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
      },
    }, {})
    vim.opt.runtimepath:prepend(lazy_path)
    self:load_lazy()
    require('lazy').install()
    return true
  end
  vim.opt.runtimepath:prepend(lazy_path)
  return false
end

function Lazy:init()
  if not self:bootstrap() then
    self:load_lazy()
  end
end

local plugins = {}

function plugins.init()
  Lazy:init()
end

function plugins.register_plugin(repo)
  table.insert(Lazy.repos, repo)
end

return plugins
