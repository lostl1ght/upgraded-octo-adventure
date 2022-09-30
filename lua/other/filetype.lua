vim.filetype.add({
  extension = {
    lua = function()
      return 'lua', function(bufnr)
        vim.bo[bufnr].shiftwidth = 2
      end
    end,
    go = function()
      return 'go',
        function(bufnr)
          vim.bo[bufnr].expandtab = false
        end
    end,
    fish = function()
      return 'fish', function(bufnr)
        vim.bo[bufnr].shiftwidth = 2
      end
    end,
    snippets = function()
      return 'snippets',
        function(bufnr)
          vim.bo[bufnr].expandtab = false
          vim.bo[bufnr].commentstring = '# %s'
        end
    end,
    zsh = 'bash',
    json = 'jsonc',
  },
  filename = {
    ['.clang-format'] = 'yaml',
    ['.clangd'] = 'yaml',
    ['.zshrc'] = 'bash',
    ['.zshenv'] = 'bash',
  },
})
