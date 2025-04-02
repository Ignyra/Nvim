--[[
============================================================================================
============================================================================================
============================================================================================
===========================================Ignyra===========================================
============================================================================================
============================================================================================
============================================================================================
--]]

--Set alternative Options
require("options")

--Set alternative Key Bindings
require("mappings")

--Load AutoCmds
require("Autocmds")

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",'--branch=stable',
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require "plugins"

-- Load theme

