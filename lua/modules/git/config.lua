local config = {}

function config.diffview()
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
end

function config.gitsigns()
  require('gitsigns').setup()
end

return config
