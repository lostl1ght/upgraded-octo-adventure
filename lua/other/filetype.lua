vim.filetype.add({
  extension = {
    zsh = 'bash',
    json = 'jsonc',
    h = 'cpp',
    html = 'htmldjango',
  },
  filename = {
    ['.clang-format'] = 'yaml',
    ['.clangd'] = 'yaml',
    ['.zshrc'] = 'bash',
    ['.zshenv'] = 'bash',
  },
  pattern = {
    ['${HOME}/.config/tmux/.*%.conf'] = 'tmux'
  }
})
