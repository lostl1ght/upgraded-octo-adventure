local config = {}

function config.neogit()
  require('neogit').setup({
    signs = {
      section = { ' ', ' ' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = { diffview = true },
  })
end

return config
