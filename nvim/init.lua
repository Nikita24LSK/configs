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
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

vim.api.nvim_create_user_command(
  'DevWork',
  function()
    vim.api.nvim_command('tabnew')
    vim.api.nvim_command('terminal')

    local platform_term_id = vim.api.nvim_exec(':echo b:terminal_job_id', true)

    vim.api.nvim_command(':call chansend('.. platform_term_id ..', "cd ~/work/android-platform-frida/\ntail -F ./logs/platform.log\n")')

    vim.cmd('norm G')

    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal')

    local scenarios_term_id = vim.api.nvim_exec(':echo b:terminal_job_id', true)

    vim.api.nvim_command(':call chansend('.. scenarios_term_id ..', "cd ~/work/android-platform-frida/\ntail -F ./logs/scenarios.log\n")')
    vim.cmd('norm G')

    vim.api.nvim_command('split')
    vim.api.nvim_command('terminal')

    local python_term_id = vim.api.nvim_exec(':echo b:terminal_job_id', true)

    vim.api.nvim_command(':call chansend('.. python_term_id ..', "cd ~/work/android-platform-frida/\n")')
    vim.api.nvim_command('wincmd J')
  end,
  {}
)
