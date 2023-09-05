-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.clipboard = 'unnamedplus'
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.tw = 79
vim.opt.colorcolumn = "-6,+1"
vim.cmd[[set autochdir]]

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

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

vim.keymap.set("n", string.format("<leader>tp"), function()
  vim.api.nvim_command('tabprevious')
end, {desc = "Close current tab"})

vim.keymap.set("n", string.format("<leader>tf"), function()
  vim.api.nvim_command('tabfirst')
end, {desc = "Close current tab"})

vim.keymap.set("n", string.format("<leader>tl"), function()
  vim.api.nvim_command('tablast')
end, {desc = "Close current tab"})

vim.keymap.set("n", string.format("<C-d>"), function()
  vim.api.nvim_command('quitall')
end)

