-- Setup the statusline with custom content (components, strings).

local Line = require('statusline/line')
local Components = require('statusline/components') -- Collection of common line modules

local contents = {
  Components.mode,
  Components.position,
  Components.lsp,
  Components.diagnostics,
  "%=", -- Align to the right
  Components.modified,
  Components.path,
  Components.permissions,
}

Line:setup(contents)
