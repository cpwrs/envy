local americano = require('americano')
local colors = require('americano.colors')

americano.setup({
  terminal = true,
  soft = true,
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = colors.red, bg = colors.soft.grey4 },
    StatusWarn = { fg = colors.orange, bg = colors.soft.grey4 },
    StatusInfo = { fg = colors.blue, bg = colors.soft.grey4 },
    StatusHint = { fg = colors.green, bg = colors.soft.grey4 },
    StatusLine = { fg = colors.white, bg = colors.soft.grey4 },
    StatusOther = { fg = colors.soft.grey1, bg = colors.soft.grey4 },
    StatusImportant = { fg = colors.bright, bg = colors.soft.grey4, bold = true },
  }
})
americano.colorscheme()
