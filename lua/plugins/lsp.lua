local L = require("configs.languages")
local lspconfig = require("lspconfig")
local M = require("configs.lspconfig")

vim.g.filetype_lookup = L[3]
vim.g.lspM = M
vim.g.server_settings = L[2]
vim.g.attached_lsps = {}

local setup_and_attachlsp = function ()
  local filetype = vim.bo.filetype
  local server = vim.g.filetype_lookup[filetype]
  local sets = vim.g.server_settings[filetype]
  vim.b.lsp_server = server
  vim.b.lsp_state = "Lsp Not Attached"

  if server ~= nil then
    local opts = {
      on_attach = M.on_attach,
      on_init = M.on_init,
      capabilities = M.capabilities,
      silent = true --We already have different detection for a server not starting
    }
    if sets ~= nil then
      for setName, set in pairs(sets) do
        opts[setName] = set
      end
    end
    lspconfig[server].setup(opts)
  
  elseif filetype == "scala" or filetype == "sbt" then
    vim.api.nvim_exec_autocmds("User", { pattern = "ScalaMetals" })
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = vim.g.lspM.on_attach
    metals_config.on_init = vim.g.lspM.on_init
    metals_config.capabilities = vim.g.lspM.capabilities
    require("metals").initialize_or_attach(metals_config)
    --require "plugins.other.scala"
  else

  end

  vim.cmd('LspStart')
end


vim.g.lspattach_on_filedetection = function ()
  
  --Most lsps shouldn't be setup again if they were setup for a different buffer, scala is an exception
  if vim.g.attached_lsps[vim.bo.filetype] ~= nil and vim.bo.filetype ~= "scala" then
    --vim.notify('Lsp Already Attached')
    return
  end
  if vim.bo.filetype == "markdown" then
    -- Trigger Markdown only if it is markdown to consume less time
    vim.api.nvim_exec_autocmds("User", { pattern = "MarkdownLoad" })
  end

  setup_and_attachlsp()
  
  
  --Install lsp server if not attached by certain time
  vim.defer_fn(function()
    --vim.notify(vim.inspect(vim.b.lsp_state))
    if vim.g.attached_lsps[vim.bo.filetype] == nil and vim.b.lsp_server ~= nil then
      --if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 0 then
      --  vim.notify("Save your new file, and reopen it to attach a server")
      --  return
      --end
      require("mason-lspconfig").setup({automatic_installation = true})
      setup_and_attachlsp()
      --vim.cmd("LspInstall " .. vim.b.lsp_server)
      --vim.notify("[INFO] " .. vim.b.lsp_server .. " took too long to load\n" .. "[INFO] Restart nvim after this installation attempt of the server")
    end
  end, 2000)

end




