---@type ChadrcConfig 
local M = {}

local highlights = require "custom.highlights"

M.ui = {
  theme = "radium",
  theme_toggle = { "radium", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
