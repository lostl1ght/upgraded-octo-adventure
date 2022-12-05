local keymap = {}
local opts = {}

function opts:new(instance)
  instance = instance
    or {
      options = {
        silent = false,
        nowait = false,
        expr = false,
        remap = false,
        buffer = nil,
      },
    }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function keymap.silent(opt)
  return function()
    opt.silent = true
  end
end

function keymap.expr(opt)
  return function()
    opt.expr = true
  end
end

function keymap.remap(opt)
  return function()
    opt.remap = true
  end
end

function keymap.nowait(opt)
  return function()
    opt.nowait = true
  end
end

function keymap.new_opts(...)
  local args = { ... }
  local o = opts:new()

  for _, arg in pairs(args) do
    local atype = type(arg)
    if atype == 'string' then
      o.options.desc = arg
    elseif atype == 'number' then
      o.options.buffer = arg
    else
      arg(o.options)()
    end
  end
  return o.options
end

local function map(mod)
  return function(tbl)
    for _, km in pairs(tbl) do
      vim.keymap.set(mod, unpack(km))
    end
  end
end

function keymap.cmd(str)
  return '<cmd>' .. str .. '<cr>'
end

keymap.nmap = map('n')
keymap.imap = map('i')
keymap.cmap = map('c')
keymap.vmap = map('v')
keymap.xmap = map('x')
keymap.tmap = map('t')

return keymap
