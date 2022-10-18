vim.filetype.add({
  extension = {
    zsh = 'bash',
    json = 'jsonc',
    h = 'cpp',
  },
  filename = {
    ['.clang-format'] = 'yaml',
    ['.clangd'] = 'yaml',
    ['.zshrc'] = 'bash',
    ['.zshenv'] = 'bash',
  },
})
