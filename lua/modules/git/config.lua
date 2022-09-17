local config = {}

function config.gitsigns()
  require('gitsigns').setup()
end

function config.lazygit()
  require('lazygit').setup()
end

return config
