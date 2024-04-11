local globals = {
  ["netrw_banner"] = 0,
  ["netrw_browse_split"] = 4,
  ["netrw_altv"] = 1,
  ["netrw_liststyle"] = 3,
}

for key, value in pairs(globals) do
  vim.g[key] = value
end
