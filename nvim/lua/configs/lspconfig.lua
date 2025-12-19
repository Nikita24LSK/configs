-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright" }
vim.lsp.enable(servers)
