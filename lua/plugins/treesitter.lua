vim.g.languages = require("configs.languages")[1]


vim.g.setuptreesitter = function ()
  if vim.fn.has('win32') == 1 then
    require('nvim-treesitter.install').compilers = { 'clang' }
  end
  local file = vim.bo.filetype
  local lang = vim.g.languages[file]
  if lang ~= nil then
    require('nvim-treesitter.configs').setup({
      ensure_installed = lang,
      highlight = {enable = true},
      indent = {enable = true}
    })
  end
end

