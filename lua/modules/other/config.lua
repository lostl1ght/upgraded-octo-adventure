local config = {}

-- Other tools
function config.persistence()
  require('persistence').setup({
    dir = vim.fs.normalize(vim.fn.stdpath('data') .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  })
end

function config.colorizer()
  require('colorizer').setup({
    filetypes = { '*' },
    user_default_options = {
      RGB = false,
      RRGGBB = true,
      names = false,
    },
  })
end

return config
