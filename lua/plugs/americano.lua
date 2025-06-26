local americano = require('americano')

local p = americano.getPalette({soft = false, dull = false})

americano.setup({
  terminal = true,
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = p.red },
    StatusWarn = { fg = p.orange },
    StatusInfo = { fg = p.blue },
    StatusHint = { fg = p.green },
    StatusLine = { fg = p.white, bg = p.grey5 },
    StatusLineNC = { fg = p.white, bg = p.grey6 },
    StatusOther = { fg = p.grey1 },
    StatusImportant = { fg = p.cream, bold = true },
  }
})

americano.colorscheme()
