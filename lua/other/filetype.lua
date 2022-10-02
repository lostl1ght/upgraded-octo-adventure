vim.filetype.add({
  extension = {
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
