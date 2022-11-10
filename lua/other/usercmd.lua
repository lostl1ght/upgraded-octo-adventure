local cmds = {}

for _, v in ipairs(cmds) do
  vim.api.nvim_create_user_command(unpack(v))
end
