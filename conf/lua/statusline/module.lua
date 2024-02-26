-- Class for different modules we want to display on the statusline.

local Module = {}

-- update: Function that returns an updated string for display
-- state: String holding the current state of the module
-- events: List of nvim event strings this module should update on
function Module.new(update, events)
  local self = setmetatable({}, {__index = Module})

  self.update = update 
  self.state = ""

  -- Always bind to WinEnter/BufEnter 
  if events then
    self.events = {"WinEnter", "BufEnter", unpack(events)}
  else
    self.events = {"WinEnter", "BufEnter"}
  end

  return self
end

function Module:exec()
  self.state = self.update()
end

return Module
