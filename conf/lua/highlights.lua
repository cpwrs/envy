-- Highlight groups

-- Core color palette
local black = "#1a1a1a"
local white = "#f7f7f7"
local dark = "#161616"
local bright = "#ffffff"

local grey0 = "#9e9e9e"
local grey1 = "#808080"
local grey2 = "#525252"
local grey3 = "#474747"
local grey4 = "#424242"
local grey5 = "#313131"
local grey6 = "#262626"

local orange = "#fdd6b6"
local cream = "#fbfbcf"
local red = "#ff4353"
local melon = "#ff909d"
local green = "#89ffcb"
local tea = "#d3ffdb"
local pink = "#ffc9f8"
local purple = "#c9a7ff"
local blue = "#c0ceff"
local turq = "#cdffff"

local highlights = {
  -- Syntax
  Comment = { fg = grey1, italic = true },
  Constant = { fg = cream }, -- DONE
  String = { fg = tea }, -- DONE
  Character = { fg = tea }, -- DONE
  Number = { fg = melon }, -- DONE 
  Boolean = { fg = orange }, -- DONE
  Float = { fg = melon }, -- DONE
  Identifier = { fg = cream }, -- DONE 
  Function = { fg = blue, italic = true },
  Conditional = { fg = turq },
  Statement = { fg = purple },
  Repeat = { fg = turq },
  Label = { fg = purple },
  Operator = { fg = green },
  Keyword = { fg = turq },
  Exception = { fg = red },
  PreProc = { fg = purple },
  PreCondit = { fg = purple },
  Include = { fg = green },
  Define = { fg = green },
  Type = { fg = pink },
  StorageClass = { fg = pink },
  Structure = { fg = purple },
  Typedef = { fg = purple },
  Special = { fg = pink },
  Delimiter = { fg = white },
  Underlined = { fg = white },
  Bold = { bold = true },
  Italic = { italic = true },
  Error = { fg = red },

  -- Editor
  ColorColumn = { fg = white },
  LineNr = { fg = grey1 },
  CursorLineNr = { fg = bright, bg = grey6, bold = true },
  CursorLineSign = { bg = grey6 },
  CursorLine = { bg = grey6 },
  SignColumn = { bg = black },
  Cursor = { bg = white, fg = black },
  lCursor = { link = "Cursor" },
  CursorIM = { link = "Cursor" },
  Directory = { fg = white },
  DiffAdd = { bg = good, fg = white },
  DiffChange = { bg = blue, fg = white },
  DiffDelete = { bg = bad, fg = white },
  EndOfBuffer = { fg = grey1, bg = black },
  ErrorMsg = { fg = bad },
  WinSeperator = { fg = black, bg = black },
  VertSplit = { link = "WinSeperator" },
  MatchParen = { link = "Cursor" },
  Normal = { fg = white, bg = black },
  NormalFloat = { fg = white, bg = grey4 },
  Float = { link = "NormalFloat" },
  NvimFloat = { link = "NormalFloat" },
  FloatBorder = { fg = grey4, bg = grey4 },
  FloatTitle = { fg = grey4, bg = green, bold = true },
  FloatFooter = { link = "NormalFloat" },
  MsgArea = { link = "Normal" },
  ModeMsg = { link = "NormalFloat" },
  NormalNC = { link = "Normal" },
  Pmenu = { fg = white, bg = grey5 },
  PmenuSel = { fg = bright, bg = grey4 },
  PmenuSbar = { fg = grey3, bg = grey5 },
  PmenuThumb = { bg = green },
  Visual = { bg = grey3 },
  VisualNOS = { link = "Visual" },

  -- Diagnostics
  DiagnosticError = { fg = red },
  DiagnosticWarn = { fg = orange },
  DiagnosticInfo = { fg = blue },
  DiagnosticHint = { fg = green },

  -- Telescope
  TelescopeTitle = { fg = grey6, bg = green, bold = true },
  TelescopeBorder = { fg = grey6, bg = grey6 },
  TelescopeNormal = { fg = white, bg = grey6 },

  -- Trouble
  TroubleNormal = { fg = white, bg = grey6 },
  
  -- Status line
  LineNormal = { fg = white, bg = grey5 },
  LineTitle = { fg = bright, bg = grey5, bold = true },
  LineImportant = { fg = green, bg = black, bold = true },
  LineError = { fg = red, bg = purple },
  LineWarn = { fg = orange, bg = grey5 },
  LineInfo = { fg = blue, bg = grey5 },
  LineHint  = { fg = good, bg = grey5 },
}

for hl, spec in pairs(highlights) do
  vim.api.nvim_set_hl(0, hl, spec)
end
