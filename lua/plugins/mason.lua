-- plugin/mason.lua

-- better to create a spereate json file to store important info. Json file updates whenever languages.lua changes
-- and other files change using an autocmd. Then this file specifically checks if mason_lang_modifed_time has
-- different time than lang_modifed_time in json and updates the servers and the times.


local M = {}
local last_modified_time = nil
local filepath = vim.fn.stdpath('config') .. '\\lua\\configs\\languages.lua'

-- Check if the file has changed, doesn't work, need to save last_modified_time
function M.check_languages_file_change()
  local stat = vim.loop.fs_stat(filepath)
  if stat == nil then
      print("Error: File not found or inaccessible - " .. filepath)
      return false
  end


  local mtime = stat.mtime.sec

  if last_modified_time == nil or mtime > last_modified_time then
      last_modified_time = mtime
      return true
  else
      return false
  end
end

-- Ensure Server Instalation
function M.reload_languages_config()
    -- Reload the languages config
    package.loaded['configs.languages'] = nil
    local servers = require("configs.languages")[2]

    require("mason-lspconfig").setup({ensure_installed = servers})
end

function M.check_and_reload()
  require("mason").setup()
  if M.check_languages_file_change() then
  --    M.reload_languages_config()
  end
end

return M


