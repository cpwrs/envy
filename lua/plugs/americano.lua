local americano = require('americano')

local p = americano.getPalette({soft = false, dull = false})

americano.setup({
  terminal = true,
  overrides = {
    -- Add status line highlights for my custom line
    StatusError = { fg = p.red, bg = p.bg },
    StatusWarn = { fg = p.orange, bg = p.bg },
    StatusInfo = { fg = p.blue, bg = p.bg },
    StatusHint = { fg = p.green, bg = p.bg },
    StatusLine = { fg = p.white, bg = p.bg },
    StatusOther = { fg = p.grey1, bg = p.bg },
    StatusImportant = { fg = p.cream, bg = p.bg, bold = true },
  }
})

americano.colorscheme()
