-- Highlight groups

-- Core color palette
local black = "#101010"
local white = "#bdbdbd"
local dark = "#000000"
local bright = "#eeeeee"

local grey0 = "#9e9e9e"
local grey1 = "#808080"
local grey2 = "#626262"
local grey3 = "#323437"
local grey4 = "#262626"
local grey5 = "#1b1b1b"
local grey6 = "#161616"

-- Syntax colors
local s_violet = "#c2a0e9"
local s_turquoise = "#8fe6e2"
local s_blue = "#a0b5f2"
local s_meh = "#c0ceee"
local s_mint = "#73f0ad"
local s_yellow = "#d5d59e"
local s_orange = "#ffc7ad"
local s_pink = "#ffbaf6"

-- Git/LSP colors
local bad = "#ff4e54"
local good = "#6dc27b"


local highlights = {
  -- Syntax
  Comment = { fg = grey2 },
  Constant = { fg = s_yellow },
  String = { fg = s_pink },
  Character = { link = "String" },
  Number = { fg = s_orange },
  Boolean = { fg = s_orange },
  Float = { link = "Number" },
  Identifier = { fg = white },
  Function = { fg = s_mint },
  Conditional = { fg = s_turquoise },
  Statement = { fg = s_turqoise },
  Repeat = { fg = s_turquoise },
  Label = { fg = s_turquoise },
  Operator = { fg = s_violet },
  Keyword = { fg = s_violet },
  Exception = { fg = bad },
  PreProc = { fg = s_turquoise },
  PreCondit = { fg = s_turquoise },
  Include = { fg = s_mint },
  Define = { fg = s_mint },
  Type = { fg = s_blue },
  StorageClass = { fg = s_blue },
  Structure = { fg = s_blue },
  Special = { fg = s_blue },
  Delimiter = { fg = s_meh },
  Underlined = { fg = white },
  Bold = { bold = true },
  Italic = { italic = true },
  Error = { fg = bad },

  -- Editor
  ColorColumn = { fg = white },
  LineNr = { fg = grey1 },
  CursorLineNr = { fg = grey0, bg = grey6, bold = true },
  CursorLineSign = { bg = grey6 },
  CursorLine = { bg = grey6 },
  SignColumn = { bg = black },
  Cursor = { bg = white, fg = black },
  lCursor = { link = "Cursor" },
  CursorIM = { link = "Cursor" },
  Directory = { fg = white },
  DiffAdd = { bg = good, fg = white },
  DiffChange = { bg = s_blue, fg = white },
  DiffDelete = { bg = bad, fg = white },
  EndOfBuffer = { fg = black, bg = black },
  ErrorMsg = { fg = bad },
  WinSeperator = { fg = black, bg = black },
  VertSplit = { link = "WinSeperator" },
  MatchParen = { link = "Cursor" },
  Normal = { fg = white, bg = black },
  NormalFloat = { fg = white, bg = grey4 },
  Float = { link = "NormalFloat" },
  NvimFloat = { link = "NormalFloat" },
  FloatBorder = { fg = grey4, bg = grey4 },
  FloatTitle = { fg = grey4, bg = s_mint, bold = true },
  FloatFooter = { link = "NormalFloat" },
  MsgArea = { link = "Normal" },
  ModeMsg = { link = "NormalFloat" },
  NormalNC = { link = "Normal" },
  Pmenu = { fg = white, bg = grey5 },
  PmenuSel = { fg = bright, bg = grey4 },
  PmenuSbar = { fg = grey3, bg = grey5 },
  PmenuThumb = { bg = s_mint },
  StatusLine = { fg = s_mint, bg = grey5, bold = true },
  StatusLineExtra = { fg = bright, bg = grey4 },
  Visual = { bg = grey3 },
  VisualNOS = { link = "Visual" },

  -- Diagnostics
  DiagnosticError = { fg = bad },
  DiagnosticWarn = { fg = s_orange },
  DiagnosticInfo = { fg = s_blue },
  DiagnosticHint = { fg = good },
  StatusError = { fg = bad, bg = grey4, bold = true },
  StatusWarn = { fg = s_orange, bg = grey4, bold = true },
  StatusInfo = { fg = s_blue, bg = grey4, bold = true },
  StatusHint  = { fg = good, bg = grey4, bold = true },

  -- Telescope
  TelescopeTitle = { fg = grey6, bg = s_mint, bold = true },
  TelescopeBorder = { fg = grey6, bg = grey6 },
  TelescopeNormal = { fg = white, bg = grey6 },

  TroubleNormal = { fg = white, bg = grey6 }
}

for hl, spec in pairs(highlights) do
  vim.api.nvim_set_hl(0, hl, spec)
end
