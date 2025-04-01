require('lazy').setup({

  --LSP Managing
  {
    'williamboman/mason.nvim',
    --event = {"BufReadPost", "BufNewFile"},
    event = "BufReadPre",
    dependencies = {'williamboman/mason-lspconfig.nvim'},
    config = function()
      require('plugins.mason').check_and_reload()
    end
  },

  {
    'neovim/nvim-lspconfig',
    --dependencies = {'williamboman/mason-lspconfig.nvim'},
    lazy = true,
    event = {"BufReadPost", "BufNewFile"},
    config = function()
      require "plugins.lsp"
      --Scala LSP
      require "plugins.other.scala"
    end
  },

  
  --Scala LSP
  --require("plugins.other.scala"),

    -- Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = "UIEnter",
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  
  --Status Line, lualine takes 40ms extra time
  {
    'echasnovski/mini.statusline',
    event = "UIEnter",
    config = function()
      require('mini.statusline').setup()
    end
  },

  
  -- Syntax Highlighting and Indetation
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    --event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require('plugins.treesitter')
    end,
    config = function(_, opts)
      if vim.fn.has('win32') == 1 then
        require('nvim-treesitter.install').compilers = { 'clang' }
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },    
  },

})
