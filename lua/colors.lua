local americano = require('americano')
local colors = require('americano.colors')

americano.setup({
  terminal = true,
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = colors.red, bg = colors.dark },
    StatusWarn = { fg = colors.orange, bg = colors.dark },
    StatusInfo = { fg = colors.blue, bg = colors.dark },
    StatusHint = { fg = colors.green, bg = colors.dark },
    StatusLine = { fg = colors.white, bg = colors.dark },
    StatusOther = { fg = colors.grey2, bg = colors.dark },
    StatusImportant = { fg = colors.bright, bg = colors.dark, bold = true },
  }
})
americano.colorscheme()
