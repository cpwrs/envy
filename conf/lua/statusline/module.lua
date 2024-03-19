-- Class for different modules we want to display on the statusline.

local Module = {}

-- update_state: Function returning a string The output of the module.
-- events: List of nvim event strings this module should update on
function Module.new(state_func, events)
  local self = setmetatable({}, {__index = Module})

  self.state = ""
  self.state_func = state_func 

  -- Bind to WinEnter/BufEnter by default, plus any events specified.
  self.events = {"WinEnter", "BufEnter", unpack(events or {})}

  return self
end

function Module:exec()
  self.state =  self.state_func()
end

return Module
