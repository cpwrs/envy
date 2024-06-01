-- oil.nvim configuration

local oil = require("oil")

oil.setup({
  default_file_explorer = true,
  columns = {},
})

vim.keymap.set('n', '<space>o', function()
  oil.open(vim.loop.cwd())
end)
