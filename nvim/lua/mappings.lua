require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local api = vim.api

local function open_aerial()
  local aerial = require("aerial")
  if vim.bo.filetype ~= "NvimTree" then
    aerial.toggle()
  end
end

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "i", "v" }, "<A-j>", "<cmd>HopWord<cr>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n" }, "<leader>a", open_aerial)
map("i", "jj", "<ESC>")
map("n", "<A-=>", "<C-w>=", { desc = "Align windows sizes" })
map("n", "=", "gg=G<C-o>:write<CR>", { desc = "Fix identation in whole file" })
map("n", "<S-CR>", "o<ESC>", { desc = "Insert blank line below" })
map("n", "<A-CR>", "O<ESC>", { desc = "Insert blank line above" })
map("n", "<C-d>", ":quitall<CR>", { desc = "Close all windows" })
map("n", "<A-d>", ":quit<CR>", { desc = "Close window without save" })
map("n", "<A-x>", ":quitall!<CR>", { desc = "Close all windows without save" })
map("n", "<leader>n", "<cmd>set nu!<CR><cmd>set rnu!<CR>", { desc = "Toggle numbers and relative numbers" })
map("n", "<leader>h", ":split<CR>", { desc = "Split horizontal window" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "Split vertical window" })
map("n", "<leader>tt", ":term<CR>", { desc = "Open term in current window" })
map("n", "<leader>tN", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Select next tab" })
map("n", "<leader>tp", ":tabprev<CR>", { desc = "Select prev tab" })
map("n", "<leader>e", ":Trouble<CR>", { desc = "Open trouble window" })
map("i", "jj", "<ESC>", { desc = "Escape from insert mode" })
map("t", "ii", "<C-\\><C-N>", { desc = "Escape from term mode"})
map("v", "J", ":m '>+<C-R>=v:count == 0 ? 1 : v:count<CR><CR>gv=gv")
map("v", "K", ":m '<-<C-R>=v:count == 0 ? 2 : v:count+1<CR><CR>gv=gv")

for i =1, 9, 1 do
  map("n", string.format("<A-%s>", i), function()
    api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

