-- Define some modules for the line.

local Module = require('statusline/module')
local LibModule = {}

-- Helper data for the diagnostics module.
diag_data = {
  {level = "Error", hl = "%#LineError#", display = "errors"},
  {level = "Warn", hl = "%#LLineWarn#", display = "warnings"},
  {level = "Info", hl = "%#LineInfo#", display = "info"},
  {level = "Hint", hl = "%#LineHint#", display = "hints"},
}

-- Show the editing mode.
LibModule.mode = Module.new(
  function() 
    local mode = vim.api.nvim_get_mode().mode
    return string.format("%s", mode)
  end,
  {"ModeChanged"}
)

-- Show the file path.
LibModule.path = Module.new(
  function()
    local fpath = vim.fn.expand("%:~:t")
    return fpath
  end
)

-- Indicator that the buffer has been modified.
LibModule.modified = Module.new(
  function()
    if vim.bo.modified then
      return "[+]"
    end
    return ""
  end,
  {"BufModifiedSet"}
)

-- Display diagnostic count by severity.
LibModule.diagnostics = Module.new(
  function()
    status = ""
    for k, data in pairs(diag_data) do
      count = vim.tbl_count(vim.diagnostic.get(0, {severity = data.level}))
      if count ~= 0 then
        status = status .. data.hl .. data.display .. " " .. count .. " "
      end
    end
    if status ~= "" then
      status = "(" .. string.sub(status, 0, -2) .. "%#LineNormal#)"
    end

    return status
  end,
  {"DiagnosticChanged"}
)

-- Show file permissions.
LibModule.permissions = Module.new(
  function()
		local fname = vim.fn.expand("%")
		local fperm = vim.fn.getfperm(fname)
  	return fperm -- Start aligning modules to the right.
  end
)

-- Show line and column position of the cursor.
LibModule.position = Module.new(
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return "%l,%c"
  end,
  {"CursorMoved"}
)

LibModule.size = Module.new(
  function()
    local fname = vim.fn.expand("%")
    local fsize = vim.fn.getfsize(fname)
    return fsize
  end
)

return LibModule
