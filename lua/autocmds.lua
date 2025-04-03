--Automatic Starting is triggered only with specifc events like FileType and BufReadPost but the first takes a long time
--while the second doesn't have the filetype loaded yet.
vim.api.nvim_create_autocmd("UIEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("LspStart")
    end,
})


vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        if vim.bo.filetype == "markdown" then
            -- Trigger Markdown
            vim.api.nvim_exec_autocmds("User", { pattern = "MarkdownLoad" })
        end
    end,
})
