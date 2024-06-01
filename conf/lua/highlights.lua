-- Highlight groups

-- Core color palette
-- local black = "#101010"
local black = "#1c1714"
local dark = "#0e0d0c"
local white = "#f7f7f7"
local bright = "#ffffff"

local grey1 = "#625f5f"
local grey2 = "#544f4d"
local grey3 = "#45403d"
local grey4 = "#3b3531"
local grey5 = "#322c27"
local grey6 = "#25201b"

local orange = "#fdd6b6"
local cream = "#fdffd1"
local red = "#ff4353"
local melon = "#ff909d"
local green = "#89ffcb"
local tea = "#d3ffdb"
local pink = "#ffb1f5"
local purple = "#d19cff"
local blue = "#a3b7ff"
local turq = "#b2ffff"

local highlights = {
  -- Syntax
  Comment         = { fg = grey1, italic = true },
  Constant        = { fg = cream },
  String          = { fg = tea },
  Character       = { fg = tea },
  Number          = { fg = melon },
  Boolean         = { fg = purple },
  Float           = { fg = melon },
  Identifier      = { fg = cream },
  Function        = { fg = blue },
  Conditional     = { fg = turq },
  Statement       = { fg = purple },
  Repeat          = { fg = turq },
  Label           = { fg = purple },
  Operator        = { fg = green },
  Keyword         = { fg = turq },
  Exception       = { fg = red },
  PreProc         = { fg = purple },
  PreCondit       = { fg = purple },
  Include         = { fg = green },
  Define          = { fg = green },
  Type            = { fg = pink },
  StorageClass    = { fg = pink },
  Structure       = { fg = purple },
  Typedef         = { fg = purple },
  Special         = { fg = pink },
  Delimiter       = { fg = bright },
  Underlined      = { fg = white },
  Bold            = { bold = true },
  Italic          = { italic = true },
  Error           = { fg = red },

  -- Editor
  LineNr          = { fg = grey1 },
  CursorLineNr    = { fg = bright },
  CursorLine      = { bg = grey6 },
  Cursor          = { bg = white, fg = black },
  lCursor         = { link = "Cursor" },
  CursorIM        = { link = "Cursor" },
  Directory       = { fg = white },
  DiffAdd         = { bg = green, fg = white },
  DiffChange      = { bg = blue, fg = white },
  DiffDelete      = { bg = red, fg = white },
  EndOfBuffer     = { fg = grey1, bg = black },
  ErrorMsg        = { fg = red },
  WinSeperator    = { fg = grey2, bg = black },
  VertSplit       = { link = "WinSeperator" },
  MatchParen      = { fg = white, bg = grey1 },
  Normal          = { fg = white, bg = black },
  NormalFloat     = { fg = white, bg = grey4 },
  NvimFloat       = { link = "NormalFloat" },
  FloatBorder     = { fg = grey4, bg = grey4 },
  FloatTitle      = { fg = green, bold = true },
  FloatFooter     = { link = "NormalFloat" },
  MsgArea         = { link = "Normal" },
  NormalNC        = { link = "Normal" },
  Pmenu           = { fg = white, bg = grey5 },
  PmenuSel        = { fg = bright, bg = grey5 },
  PmenuSbar       = { fg = grey3, bg = grey5 },
  PmenuThumb      = { bg = cream},
  Visual          = { bg = grey5 },
  VisualNOS       = { link = "Visual" },
  TabLine         = { fg = grey1, bg = grey6 },
  TabLineSel      = { fg = bright, bg = black },
  TabLineFill     = { fg = grey1, bg = grey6 },
  IncSearch       = { fg = cream, bg = grey1 },
  CurSearch       = { fg = cream, bg = grey1 },
  Search          = { fg = cream, bg = grey5 },

  -- Diagnostics
  DiagnosticError = { fg = red },
  DiagnosticWarn  = { fg = orange },
  DiagnosticInfo  = { fg = blue },
  DiagnosticHint  = { fg = green },

  -- Telescope
  TelescopeTitle  = { fg = green, bg = grey5, bold = true },
  TelescopeBorder = { fg = grey5, bg = grey5 },
  TelescopeNormal = { fg = white, bg = grey5 },

  -- Status line
  LineNormal      = { fg = white, bg = dark },
  LineImportant   = { fg = bright, bg = dark, bold = true },
}

for hl, spec in pairs(highlights) do
  vim.api.nvim_set_hl(0, hl, spec)
end
