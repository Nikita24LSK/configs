return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
    lazy = false
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier",
        "pyright", "clangd", "cpplint", "flake8",
        "debugpy"
  		},
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python",
        "java", "javascript",
        "c", "cpp", "rust",
        "asm", "bash", "cmake",
        "make", "go"
  		},
  	},
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {}
  },

  {
    'stevearc/aerial.nvim',
    cmd = "AerialToggle",
    opts = {},
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require "configs.aerial"
    end,
  },

  {
    "smoka7/hop.nvim",
    cmd = "HopWord",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran"
    }
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      stages = "slide",
      timeout = 4000
    }
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = false
  },

}

