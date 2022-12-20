local M = { 'dnlhc/glance.nvim' }

M.cmd = 'Glance'

M.dependencies = { 'neovim/nvim-lspconfig' }

M.config = function()
  require('glance').setup({
    hooks = {
      before_open = function(results, open, jump, method)
        local uri = vim.uri_from_bufnr(0)
        if #results == 1 then
          local target_uri = results[1].uri or results[1].targetUri

          if target_uri == uri then
            jump(results[1])
          else
            open(results)
          end
        else
          open(results)
        end
      end,
    },
  })
end

return M
