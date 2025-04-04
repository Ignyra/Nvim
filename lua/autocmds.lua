--Automatic Starting is triggered only with specifc events like FileType and BufReadPost but the first takes a long time
--while the second doesn't have the filetype loaded yet.
vim.api.nvim_create_autocmd("UIEnter", {
    --pattern = "*",
    callback = function()
      if vim.bo.filetype == "markdown" then
        -- Trigger Markdown
        vim.api.nvim_exec_autocmds("User", { pattern = "MarkdownLoad" })
      end

      vim.schedule(function ()
        vim.cmd("LspStart")
      end)

      --Install lsp server if not attached by certain time
      vim.defer_fn(function()
        if vim.g.lsp_state ~= "Lsp Attached" and vim.g.lsp_server ~= nil then
          require("mason-lspconfig").setup()
          vim.cmd("LspInstall " .. vim.g.lsp_server)
          vim.notify("[INFO] " .. vim.g.lsp_server .. " took too long to load\n" .. "[INFO] Restart nvim after this installation attempt of the server")
        end
      end, 4000)
    end,
})

--Mark as attached so to not waste time on rensuring the server installation
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function ()
    vim.g.lsp_state = "Lsp Attached"
  end
})

