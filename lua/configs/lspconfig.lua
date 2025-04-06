local cmp_nvim_lsp = require("cmp_nvim_lsp")


local M = {}

-- Keymaps only activate when the LSP is attached
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP: " .. desc }
  end

  local map = vim.keymap.set
  --map({'n', 'v'}, 'gt', vim.lsp.buf.type_definition, opts("type_definition"))
  map("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
  map("n", "gD", vim.lsp.buf.declaration, opts("Go to Declaration"))
  map("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
  map("n", "gr", vim.lsp.buf.references, opts("Find References"))
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show Signature Help"))
  map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
end

-- Disable `semanticTokens` if it causes visual issues
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- Enhanced capabilities for autocompletion, hover docs, etc.
--M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
  },
}

return M

