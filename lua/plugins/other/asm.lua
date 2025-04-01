if vim.fn.exepath("cargo") ~= "" then
  --vim.notify("[INFO] Cargo already installed.", vim.log.levels.INFO)
  return true
end

print("[INFO] Cargo not found. Installing now...")
if vim.fn.has("win32") == 1 then
  -- Download rustup-init.exe
  local installer_path = vim.fn.stdpath("cache") .. "\\rustup-init.exe"
  local download_cmd = string.format('powershell -Command "Invoke-WebRequest -Uri %s -OutFile %s"',"https://win.rustup.rs/" , installer_path)
  os.execute(download_cmd)

  -- Run the installer silently
  local install_cmd = string.format('powershell -Command "Start-Process -FilePath \\"%s\\" -ArgumentList \'-y\' -NoNewWindow -Wait"',installer_path)
  os.execute(install_cmd)
else
  -- Linux/macOS: run the shell install script
  os.execute('curl https://sh.rustup.rs -sSf | sh')
end

if vim.fn.exepath("cargo") == "" then
  vim.notify("[ERROR] Failed to install Cargo.", vim.log.levels.ERROR)
  return false
else
  vim.notify("[INFO] Cargo successfully installed.", vim.log.levels.INFO)
  return true
end


