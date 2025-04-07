local lspconfig = require("lspconfig")
local M = require("configs.lspconfig")
lspconfig.metals.setup {
  cmd = { "metals" },
  filetypes = { "scala", "sbt" },
  root_dir = lspconfig.util.root_pattern("build.sbt", "build.sc", ".git"),
  on_attach = M.on_attach,
  on_init = M.on_init,
  capabilities = M.capabilities,
  
  settings = {
    metals = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      bloopSbtAlreadyInstalled = true,          -- Prevents Bloop reinstallation
      disableAutomaticWorkspaceReindexing = true, -- Stops indexing on every startup
      enableSemanticHighlighting = true,        -- Faster highlighting via LSP
    },
  },

  init_options = {
    statusBarProvider = "on",  -- Better status updates during indexing
    isHttpEnabled = true,      -- Enables HTTP client for Metals’ internal tools
    metalsBinaryPath = vim.fn.expand("$HOME/.local/share/coursier/bin/metals"), -- Faster resolution using cached path
  },
}

--return {
--  "scalameta/nvim-metals",
--  dependencies = {
--    "nvim-lua/plenary.nvim",
--  },
--  ft = { "scala", "sbt", "java" },
--  opts = function()
--    local metals_config = require("metals").bare_config()
--    --metals_config.on_attach = function(client, bufnr)
--    --  -- your on_attach function
--    --end
--
--    return metals_config
--  end,
--  config = function(self, metals_config)
--    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
--    vim.api.nvim_create_autocmd("FileType", {
--      pattern = self.ft,
--      callback = function()
--        require("metals").initialize_or_attach(metals_config)
--      end,
--      group = nvim_metals_group,
--    })
--  end
--}
