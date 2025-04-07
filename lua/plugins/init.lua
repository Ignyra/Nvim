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
    --event = 'BufReadPost',
    event = {'BufReadPost', 'BufNewFile'},
    --event = "BufEnter",
    --event = "LspAttach",
    config = function()
      require "plugins.lsp"
    end,
    lazy = true
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
        "ftplugin", --Takes a lot of time to load when first time opening a filetype in a session, syntax too
        "syntax"
      },
    },
  },
  
}
)
