-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.tw = 79
vim.opt.colorcolumn = "-6,+1"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<CR>', 'o<Esc>')

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

vim.keymap.set("n", string.format("<leader>tN"), function()
  vim.api.nvim_command('tabnew')
end, {desc = "Create new tab"})

vim.keymap.set("n", string.format("<leader>tx"), function()
  vim.api.nvim_command('tabclose')
end, {desc = "Close current tab"})

vim.keymap.set("n", string.format("<leader>tn"), function()
  vim.api.nvim_command('tabnext')
end, {desc = "Next tab"})

vim.keymap.set("n", string.format("<A-Tab>"), function()
  vim.api.nvim_command('tabnext')
end, {desc = "Next tab"})

vim.keymap.set("n", string.format("<leader>tp"), function()
  vim.api.nvim_command('tabprevious')
end, {desc = "Move to previous tab"})

vim.keymap.set("n", string.format("<leader>tf"), function()
  vim.api.nvim_command('tabfirst')
end, {desc = "Move to first tab"})

vim.keymap.set("n", string.format("<leader>tl"), function()
  vim.api.nvim_command('tablast')
end, {desc = "Move to last tab"})

vim.keymap.set("n", string.format("<leader>ttt"), function()
  vim.api.nvim_command('terminal')
end, {desc = "Spawn terminal in current buffer"})

vim.keymap.set("n", string.format("<leader>tth"), function()
  vim.api.nvim_command('split')
  vim.api.nvim_command('terminal')
end, {desc = "Spawn terminal in split buffer"})

vim.keymap.set("n", string.format("<leader>ttv"), function()
  vim.api.nvim_command('vsplit')
  vim.api.nvim_command('terminal')
end, {desc = "Spawn terminal in vsplit buffer"})

vim.keymap.set("n", string.format("<C-d>"), function()
  vim.api.nvim_command('quitall')
end, {desc = "Quitall"})

vim.keymap.set("n", string.format("<leader>wh"), function()
  vim.api.nvim_command('split')
end, {desc = "Split window"})

vim.keymap.set("n", string.format("<leader>wv"), function()
  vim.api.nvim_command('vsplit')
end, {desc = "Vertical split window"})

vim.keymap.set("n", string.format("<leader>if"), function()
  vim.api.nvim_command('AerialToggle')
end, {desc = "View functions"})


