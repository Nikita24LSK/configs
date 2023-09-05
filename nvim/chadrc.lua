---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "radium",
  theme_toggle = { "radium", "one_light" },

  changed_themes = {
    radium = {
      base08 = "#e87979",
      base0C = "#e87979",
      base0B = "#37d99e",
      base0F = "#37d99e"
    },
  },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
