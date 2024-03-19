-- Define the components (Modules, strings) that make up the status line, and set up their autocommands.

local Line = require('statusline/line')
local Lib = require('statusline/libmodule') -- Collection of common line modules

components = {
  "%#LineImportant#",
  Lib.mode,
  "%#LineTitle# File%#LineNormal#",
  Lib.path,
  Lib.modified,
  Lib.permissions,
  "%=",
  "%#LineTitle#Lsp%#LineNormal# ",
  Lib.lsp,
  Lib.diagnostics,
  "%#LineImportant#",
  Lib.position,
}

Line:setup(components)
