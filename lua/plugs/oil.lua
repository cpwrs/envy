-- oil.nvim configuration

local oil = require("oil")

oil.setup({
  default_file_explorer = true,
  columns = {},
  win_options = {
    signcolumn = "no",
  },
  view_options = {
    show_hidden = true,
  }
})

vim.keymap.set('n', '<space>o', function() oil.open() end)
