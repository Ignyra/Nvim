require('lazy').setup({
  

  --Fun Games: https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#game
  {'Eandrju/cellular-automaton.nvim', event = "User Games"},
  {
    'jim-fx/sudoku.nvim',
    event = "User Games",
    cmd = "Sudoku",
    config = function()
      require("sudoku").setup({})
    end
  },
  {"alanfortlink/blackjack.nvim", event = "User Games"},
  --{
  --  "kawre/leetcode.nvim",
  --  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  --  dependencies = {
  --      "nvim-telescope/telescope.nvim",
  --      -- "ibhagwan/fzf-lua",
  --      "nvim-lua/plenary.nvim",
  --      "MunifTanjim/nui.nvim",
  --  },
  --  event = "User Games",
  --  opts = {
  --      -- configuration goes here
  --  },
  --}
  
  --LSP Managing
  {
    'williamboman/mason.nvim',
    event = {"BufReadPre", "BufNewFile"},
    config = function()
      require('mason').setup()
    end
  },

  

  {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason-lspconfig.nvim'},
    --event = "FileType",
    event = 'User LSPandTreeSitter',
    --event = {'BufReadPost', 'BufNewFile'},
    --event = "BufEnter",
    --event = "LspAttach",
    config = function()
      require "plugins.lsp"
    end,
    lazy = true
  },

  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = 'User ScalaMetals',
    ft = { "scala", "sbt", "java" },
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

  --Git, takes 40 ms extra
  {
    'lewis6991/gitsigns.nvim',
    event = 'UIEnter',
    config = function ()
      require('gitsigns').setup()
    end
  },
 
  --Status Line and tabline, lualine takes 40ms extra time than mini
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'UIEnter',
    config = function ()
      require('lualine').setup({
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'}
        }
      })
    end
  },
  --{
  --  'echasnovski/mini.statusline',
  --  event = "UIEnter",
  --  config = function()
  --    require('mini.statusline').setup()
  --  end
  --},

  --{ 
  --  'echasnovski/mini.tabline',
  --  dependencies = 'echasnovski/mini.icons',
  --  event = "UIEnter",
  --  config = function()
  --    require('mini.icons').setup()
  --    require("mini.tabline").setup({
  --      show_icons = true,
  --      format = nil,
  --      set_vim_settings = true,
  --      tabpage_section = 'none'
  --    })
  --  end
  --},

  --Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "UIEnter"
  },

  --{
  --  "nvim-tree/nvim-tree.lua",
  --  config = function ()
  --    require("nvim-tree").setup()
  --  end
  --},
  
  -- Syntax Highlighting and Indetation
  {
    'nvim-treesitter/nvim-treesitter',
    --build = ':TSUpdate',
    lazy = true,
    event = 'User LSPandTreeSitter',
    --event = { "BufReadPost", "BufNewFile" },
    config = function()
      require 'plugins.treesitter'
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
        "ftplugin", --Takes a lot of time to load when first time opening a filetype in a session, syntax too
        "syntax",
        "rplugin"
      },
    },
  },
  
}
)
