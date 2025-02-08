-- Setup the statusline with custom content (components, strings).

local line = require('statusline/line')
local components = require('statusline/components')

local contents = {
  components.mode,
  components.position,
  components.lsp,
  components.diagnostics,
  "%#StatusOther#%q", -- Quickfix indicator
  "%=", -- Align to the right
  components.modified,
  components.path,
  components.permissions,
}

line.setup(contents)
