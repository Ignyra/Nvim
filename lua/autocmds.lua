--Automatic Starting is triggered only with specifc events like FileType and BufReadPost but the first takes a long time
--while the second doesn't have the filetype loaded yet.



vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile'}, {
  callback = function(args)
    vim.b.did_ftplugin = 1 --disbale vim's built in syntax and indent
    --vim.b.undo_ftplugin = "" --c files require this to be set in older version of nvim, fixed in https://github.com/neovim/neovim/commit/50577534318bbf8c1e22e80a74baa3b20c131ea8#diff-9d87561b815ec0a333a78e3bd6cb87fb25c6261b67f6b4ad1839c975ca3394cbR14
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "LSPandTreeSitter" })
      vim.g.lspattach_on_filedetection() --wait for the function to be created by lsp.lua
      vim.g.setuptreesitter()
    end)
    --vim.api.nvim_create_autocmd("BufWinEnter", {
    --  buffer = args.buf,
    --  once = true,
    --  callback = vim.g.lspattach_on_filedetection
    --})
  end
})



--Mark as attached so to not waste time on rensuring the server installation
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (args)
    local bufnr = args.buf
    vim.g.attached_lsps = vim.tbl_deep_extend(
    "force",
    vim.g.attached_lsps,
    {[vim.bo[bufnr].filetype] = "Lsp Attached"}
    )
    vim.notify("Lsp Attached")

    --vim.api.nvim_buf_set_var(bufnr, "lsp_state", "Lsp Attached") 
    --vim.g.lsp_state = "Lsp Attached"
  end
})




