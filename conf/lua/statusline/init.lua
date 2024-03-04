
local Line = require('statusline/line')
local Lib = require('statusline/libmodule') -- Collection of common line modules

Line.components = {
  "%#LineImportant# ", -- Change hl group
  Lib.mode, " ",
  Lib.position,
  " %#LineTitle# file %#LineNormal#",
  Lib.path, " ",
  Lib.modified, " ",
  Lib.permissions, " ",
  Lib.size,
  "%=", -- Align right
  "%#LineTitle#lsp %#LineNormal#",
}

Line:create_autocmds()
