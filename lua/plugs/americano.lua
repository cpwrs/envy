local americano = require('americano')
local colors = require('americano.colors')

americano.setup({
  terminal = true,
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = colors.red, bg = colors.grey4 },
    StatusWarn = { fg = colors.orange, bg = colors.grey4 },
    StatusInfo = { fg = colors.blue, bg = colors.grey4 },
    StatusHint = { fg = colors.green, bg = colors.grey4 },
    StatusLine = { fg = colors.white, bg = colors.grey4 },
    StatusOther = { fg = colors.grey1, bg = colors.grey4 },
    StatusImportant = { fg = colors.bright, bg = colors.grey4, bold = true },
  }
})
americano.colorscheme()
