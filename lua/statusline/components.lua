-- A component holds the state for a dynamic part of the statusline
-- It is a table whos first element is a function returning a string (text to display)
-- and second element is an optional list of strings (neovim autocmd events)
local components = {}

-- Translations for the mode component.
local translate_mode = {
  ["n"] = "norm",
  ["no"] = "norm",
  ["v"] = "visl",
  ["V"] = "visl",
  [""] = "visl",
  ["s"] = "slct",
  ["S"] = "slct",
  [""] = "slct",
  ["i"] = "nsrt",
  ["ic"] = "nsrt",
  ["R"] = "rplc",
  ["Rv"] = "rplc",
  ["c"] = "cmnd",
  ["r"] = "prmt",
  ["rm"] = "more",
  ["r?"] = "cfrm",
  ["!"] = "shll",
  ["t"] = "term",
  ["nt"] = "term",
}

-- Show the editing mode.
components.mode = {
  function()
    local mode = translate_mode[vim.api.nvim_get_mode().mode]
    if mode == nil then mode = "mode" end
    return "%#StatusImportant#" .. string.format("%s", mode) .. "%*"
  end,
  { "ModeChanged" }
}

-- Check if the file has been modified
local function modified()
  if vim.bo.modified then
    return "%*+"
  end
  return ""
end

-- Show the file path, relative to the project root dir.
components.path = {
  function()
    local filename = vim.fn.expand("%:t")
    -- Relative path without the filename and a / at the end
    local relativepath = vim.fn.expand("%:.:h") .. "/"
    return modified() .. "%#StatusOther#" .. relativepath .. "%#StatusImportant#" .. filename .. "%*"
  end,
  { "BufModifiedSet" },
}

-- Indicator that the buffer has been modified.
components.modified = {
  function()
    if vim.bo.modified then
      return "%*+"
    end
    return ""
  end,
  { "BufModifiedSet" }
}

-- Severities and their associated hl for the diagnostics component.
local severities = {
  [vim.diagnostic.severity.ERROR] = "%#StatusError#",
  [vim.diagnostic.severity.WARN] = "%#StatusWarn#",
  [vim.diagnostic.severity.INFO] = "%#StatusInfo#",
  [vim.diagnostic.severity.HINT] = "%#StatusHint#",
}

-- Display diagnostic count by severity.
-- Helper function for the main lsp component.
local function diagnostics()
  local diags = ""
  for sev, hl in pairs(severities) do
    local count = #vim.diagnostic.get(0, { severity = sev })
    if count ~= 0 then
      diags = diags .. hl .. count .. "%#StatusOther#,%*"
    end
  end

  if diags ~= "" then
    diags = "%#StatusOther#[%*" .. string.sub(diags, 1, -4) .. "]%*"
  end
  return diags
end

components.lsp = {
  function()
    local lsp = ""
    local clients = vim.lsp.get_clients({bufnr = 0})

    if next(clients) ~= nil then
      for _, client in pairs(clients) do
        lsp = lsp .. client.name
      end
    end

    return lsp .. diagnostics()
  end,
  { "LspAttach", "LspDetach", "DiagnosticChanged" }
}

-- Show file permissions.
components.permissions = {
  function()
    local fpath = vim.fn.expand("%")
    local fperm = vim.fn.getfperm(fpath)

    if fperm ~= "" then
      return "%#StatusOther#(%*" .. fperm .. "%#StatusOther#)%*"
    else
      return ""
    end
  end
}

-- Show line and column position of the cursor.
components.position = {
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return "%l%#StatusOther#:%*%c"
  end,
  { "CursorMoved" }
}

return components
