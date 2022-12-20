local M = { 'L3MON4D3/LuaSnip' }

M.config = function()
  require('luasnip.loaders.from_snipmate').lazy_load()
end

return M
