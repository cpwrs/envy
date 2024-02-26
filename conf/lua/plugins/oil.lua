-- Oil plugin configuration

local oil = require('oil')

oil.setup {
	default_file_explorer = true,
	columns = {},
}

return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    columns = {},
  },
}
