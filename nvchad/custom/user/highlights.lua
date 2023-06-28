-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
    --fg = "#323232",
  },

  NvimTreeOpenedFolderName = { 
    --fg = "#9099dd", 
    bold = true
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "#9099dd", bold = true },
}

return M
