-- Setup the statusline with custom content (components, strings).

local Line = require('statusline/line')
local Components = require('statusline/components')

local contents = {
  Components.mode,
  Components.position,
  Components.lsp,
  Components.diagnostics,
  "%#StatusOther#%q", -- Quickfix indicator
  "%=", -- Align to the right
  Components.modified,
  Components.path,
  Components.permissions,
}

Line:setup(contents)
