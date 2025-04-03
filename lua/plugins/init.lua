require('lazy').setup({

  --LSP Managing
  {
    'williamboman/mason.nvim',
    event = "BufReadPre",
    config = function()
      require('mason').setup()
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason-lspconfig.nvim'},
    --event = "FileType",
    event = "BufEnter",
    --event = "UIEnter",
    config = function()
      require "plugins.lsp"
    end
  },
  

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
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons'},
    event = "User MarkdownLoad",
    config = function()
      require("render-markdown").setup({
       preset = "obsidian" 
      })
    end
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
    config = function()
      require "plugins.cmp"
    end,
  },
},
{  
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "tutor",
  
        "tohtml",
        "spellfile_plugin",
      },
    },
  },
  
}
)
