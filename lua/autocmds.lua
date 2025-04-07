--Automatic Starting is triggered only with specifc events like FileType and BufReadPost but the first takes a long time
--while the second doesn't have the filetype loaded yet.



vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile'}, {
  callback = function(args)
    vim.schedule(function()
      vim.g.lspattach_on_filedetection() --wait for the function to be created by lsp.lua
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

    --vim.api.nvim_buf_set_var(bufnr, "lsp_state", "Lsp Attached") 
    --vim.g.lsp_state = "Lsp Attached"
  end
})




