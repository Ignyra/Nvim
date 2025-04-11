vim.g.languages = require("configs.languages")[1]


vim.g.setuptreesitter = function ()
  require('nvim-treesitter.install').compilers = {'gcc'} --update gcc to latest version
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

