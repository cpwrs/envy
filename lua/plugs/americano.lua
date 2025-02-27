local americano = require('americano')

local p = americano.getPalette({soft = false, dull = false})

americano.setup({
  terminal = true,
  palette_config = {
    soft = false,
    dull = true,
  },
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = p.red, bg = p.grey4 },
    StatusWarn = { fg = p.orange, bg = p.grey4 },
    StatusInfo = { fg = p.blue, bg = p.grey4 },
    StatusHint = { fg = p.green, bg = p.grey4 },
    StatusLine = { fg = p.white, bg = p.grey4 },
    StatusOther = { fg = p.grey1, bg = p.grey4 },
    StatusImportant = { fg = p.cream, bg = p.grey4, bold = true },
  }
})

americano.colorscheme()
