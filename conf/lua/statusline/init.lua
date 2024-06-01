-- Setup the statusline with custom content (components, strings).

local Line = require('statusline/line')
local Components = require('statusline/components') -- Collection of common line modules

Line.setup({
  "%#LineImportant#",
  Components.mode,
  "%#LineNormal#",
  Components.position,
  Components.lsp,
  Components.diagnostics,
  "%=",
  Components.modified,
  Components.path,
  Components.permissions,
})
