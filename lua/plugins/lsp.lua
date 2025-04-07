--local servers = require("configs.languages")[2]
local filetype_lookup = require("configs.languages")[3]
local lspconfig = require("lspconfig")
--local mason_lspconfig = require("mason-lspconfig")
local M = require("configs.lspconfig")

--Checking every server and loading lspconfig takes extra around 7 extra ms than checking one specifc server
--mason-lspconfig takes extra 20ms for installation
--require("mason-lspconfig").setup({
--  ensure_installed = servers
--})

--require("mason-lspconfig").setup_handlers({
--  function(server)
--    lspconfig[server].setup(opts_lookup[server])
--  end,
--})

--require("mason-lspconfig").setup({
--  ensure_installed = {"lua_ls"}
--})


--lspconfig["lua_ls"].setup({})
--for _,server in ipairs(servers) do
--  lspconfig[server].setup(opts_lookup[server])
--end

--mason_lspconfig.setup({
--  automatic_installation = true
--})

vim.g.filetype_lookup = filetype_lookup
vim.g.lspM = M
vim.g.attached_lsps = {}

local setup_and_attachlsp = function ()
  local filetype = vim.bo.filetype
  local server = vim.g.filetype_lookup[filetype]
  vim.b.lsp_server = server
  vim.b.lsp_state = "Lsp Not Attached"
  
  if server == 'lua_ls' then
    lspconfig.lua_ls.setup({
      settings = {Lua = {diagnostics = {globals = {'vim'}},}},
      on_attach = vim.g.lspM.on_attach,
      on_init = vim.g.lspM.on_init,
      capabilities = vim.g.lspM.capabilities,
      silent = true --We already have different detection for a server not starting
    })
  
  elseif server ~= nil then
    lspconfig[server].setup({
      on_attach = M.on_attach,
      on_init = M.on_init,
      capabilities = M.capabilities,
      silent = true --We already have different detection for a server not starting
    })
  elseif filetype == "scala" or filetype == "sbt" then
    vim.api.nvim_exec_autocmds("User", { pattern = "ScalaMetals" })
    --require "plugins.other.scala"
  end

  vim.cmd('LspStart')
end


vim.g.lspattach_on_filedetection = function ()
  
  if vim.g.attached_lsps[vim.bo.filetype] ~= nil then
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
  end, 1000)

end




