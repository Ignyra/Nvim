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


local filetype = vim.bo.filetype
local server = filetype_lookup[filetype]
vim.g.lsp_state = "Lsp Not Attached"
vim.g.lsp_server = server


if server ~= nil then
  lspconfig[server].setup({
    on_attach = M.on_attach,
    on_init = M.on_init,
    capabilities = M.capabilities,
    silent = true --We already have different detection for a server not starting
  })
elseif filetype == "scala" or filetype == "sbt" then
  require "plugins.other.scala"
end

