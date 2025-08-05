require "nvchad.options"
require "snippets"

local cmd = vim.cmd
local api = vim.api
local opt = vim.opt
local wo = vim.wo
local o = vim.o

api.nvim_set_hl(0, "StatusLine", {reverse = false})
api.nvim_set_hl(0, "StatusLineNC", {reverse = false})

-- Custom commands
api.nvim_create_user_command('ReadColor',
  function()
    local fpath = api.nvim_buf_get_name(0)
    cmd("term less -R " .. fpath )
  end,
{})

-- opt section
opt.tw = 79
opt.colorcolumn = "-6,+1"
opt.scrolloff = 5
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.fillchars = {
  fold = " ",
  eob = " ",
  foldsep = "|",
  foldopen = "",
  foldclose = ""
}

-- wo section
wo.relativenumber = true

-- o section
o.cursorlineopt ="both"
o.termguicolors = true

