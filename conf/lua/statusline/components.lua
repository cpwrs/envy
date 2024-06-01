-- Library of components to display on the statusline

local Comp = {}

-- update_state: Function returning a string The output of the module.
-- events: List of nvim event strings this module should update on
function Comp.new(state_func, events)
  local self = setmetatable({}, {__index = Comp})

  self.state = ""
  self.state_func = state_func

  -- Bind to WinEnter/BufEnter by default, plus any events specified.
  self.events = {"WinEnter", "BufEnter", unpack(events or {})}

  return self
end

function Comp:exec()
  self.state =  self.state_func()
end


-- Define some modules for the line.
local Components = {}

-- Severities and their associated hl for the diagnostics component.
local severities = {
  {severity = vim.diagnostic.severity.ERROR, hl = "%#DiagnosticError#"},
  {severity = vim.diagnostic.severity.WARN, hl = "%#DiagnosticWarn#"},
  {severity = vim.diagnostic.severity.INFO, hl = "%#DiagnosticInfo#"},
  {severity = vim.diagnostic.severity.HINT, hl = "%#DiagnosticHint#"},
}

-- Translations for the mode component.
local translate_mode = {
  ["n"] = "Norm",
  ["no"] = "Norm",
  ["v"] = "Visl",
  ["V"] = "Visl",
  [""] = "Visl",
  ["s"] = "Slct",
  ["S"] = "Slct",
  [""] = "Slct",
  ["i"] = "Nsrt",
  ["ic"] = "Nsrt",
  ["R"] = "Rplc",
  ["Rv"] = "Rplc",
  ["c"] = "Cmnd",
  ["r"] = "Prmt",
  ["rm"] = "More",
  ["r?"] = "Cfrm",
  ["!"] = "Shll",
  ["t"] = "Term",
}

-- Show the editing mode.
Components.mode = Comp.new(
  function()
    local mode = translate_mode[vim.api.nvim_get_mode().mode]
    if mode == nil then mode = "Mode" end
    return string.format(" %s", mode)
  end,
  {"ModeChanged"}
)

-- Show the file path, relative to the project root dir.
Components.path = Comp.new(
  function()
    local fname = vim.fn.expand("%")
    local fpath = string.gsub(fname, vim.loop.cwd(), '')
    return fpath
  end
)

-- Indicator that the buffer has been modified.
Components.modified = Comp.new(
  function()
    if vim.bo.modified then
      return "+"
    end
    return ""
  end,
  {"BufModifiedSet"}
)

-- Display diagnostic count by severity.
Components.diagnostics = Comp.new(
  function()
    local status = ""

    for severity in severities do
      local count = #vim.diagnostic.get(0, {severity = severity})
      if count ~= 0 then
        status = status .. severity.hl .. count
      end
    end

    if status ~= "" then
      status = " " .. status .. "%#LineNormal#"
    else
      status = " "
    end

    return status
  end,
  {"DiagnosticChanged"}
)

Components.lsp = Comp.new(
  function()
    local lsp = ""
    local clients = vim.lsp.get_clients()

    if next(clients) == nil then
      lsp = ""
    else
      for _, client in pairs(clients) do
        lsp = lsp .. client.name
      end
    end

    return " " .. lsp
  end,
  {"LspAttach", "LspDetach"}
)

-- Show file permissions.
Components.permissions = Comp.new(
  function()
		local fname = vim.fn.expand("%")
		local fperm = " " .. vim.fn.getfperm(fname) .. " "
  	return fperm
  end
)

-- Show line and column position of the cursor.
Components.position = Comp.new(
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return " %l,%c"
  end,
  {"CursorMoved"}
)

Components.size = Comp.new(
  function()
    local fname = vim.fn.expand("%")
    local fsize = vim.fn.getfsize(fname)
    local size_string = ""

    if (fsize == -1) or (fsize == -2) then
      size_string = ""
    else
      size_string = " " .. fsize .. "B"
    end

    return size_string
  end
)

return Components
