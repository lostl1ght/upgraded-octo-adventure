local M = { 'ggandor/leap.nvim' }

M.event = 'VeryLazy'

M.dependencies = {
  { 'ggandor/flit.nvim' },
  { 'ggandor/leap-ast.nvim' },
}

M.config = function()
  require('leap').add_default_mappings()
  require('flit').setup({
    labeled_modes = 'nv',
  })
  vim.keymap.set({ 'n', 'x', 'o' }, 'M', function()
    require('leap-ast').leap()
  end, { desc = 'Leap ast' })
end

return M
