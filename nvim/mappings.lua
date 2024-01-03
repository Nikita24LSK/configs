local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>drm"] = {
      function()
        require('dap-python').test_method()
      end
    },
    ["<leader>drc"] = {
      function()
        require('dap-python').test_class()
      end
    },
    ["<leader>drs"] = {
      function()
        require('dap-python').debug_selection()
      end
    },

  }
}

M.user = {
  n = {
    ["<leader>tN"] = {"<cmd> tabnew <CR>", "Create new tab"},
    ["<leader>tx"] = {"<cmd> tabclose <CR>", "Close tab"},
    ["<leader>tn"] = {"<cmd> tabnext <CR>", "Next tab"},
    ["<leader>tp"] = {"<cmd> tabprevious <CR>", "Previous tab"},
    ["<leader>tt"] = {"<cmd> terminal <CR>", "Run terminal"},
    ["<leader>th"] = {"<cmd> split <CR><cmd> terminal <CR>", "Run horizontal terminal"},
    ["<leader>tv"] = {"<cmd> vsplit <CR><cmd> terminal <CR>", "Run vertical terminal"},
    ["<leader>v"] = {"<cmd> vsplit <CR>", "Window split vertical"},
    ["<leader>h"] = {"<cmd> split <CR>", "Window split horizontal"},
    ["<S-CR>"] = {"o<Esc>", "Insert blank line below"},
    ["<C-d>"] = {"<cmd> quitall <CR>", "Close all windows"},
    ["<A-CR>"] = {"O<Esc>", "Insert blank line above"},
    ["<A-Tab>"] = {"<cmd> tabnext <CR>", "Go to next tab"},
    ["<A-d>"] = {"<cmd> quit <CR>", "Close window"},
    ["<A-x>"] = {"<cmd> quitall! <CR>", "Close all windows without saving"},
    ["<leader>pdo"] = {"<cmd> DiffviewOpen <CR>", "Open DiffView"},
    ["<leader>pdc"] = {"<cmd> DiffviewClose <CR>", "Close DiffView"},
    ["<leader>pa"] = {"<cmd> AerialToggle <CR>", "Toggle Aerial"},
    ["<leader>pe"] = {"<cmd> TroubleToggle document_diagnostics <CR>", "Toggle Trouble"},
  },
  v = {},
  i = {},
}

return M
