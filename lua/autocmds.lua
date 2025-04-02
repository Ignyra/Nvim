-- Lua code for Neovim
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.txt",  -- Replace with the desired file pattern or leave as * for all files
    callback = function()
        print("File was saved!")  -- Replace this with your custom function
        MyCustomFunction()
    end,
})

