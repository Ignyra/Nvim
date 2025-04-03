# Nvim: My own configuration

Inspired by [Nvchad](https://github.com/NvChad/NvChad) and [kickstart](https://github.com/nvim-lua/kickstart.nvim)

## Setup

### Linux

Download nvim:
```
wget "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
tar -xzf nvim-linux-x86_64.tar.gz
./nvim-linux-x86_64/bin/nvim
```

or Build Neovim Instead:
```
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local
make install
```

Then clone the configs:
```
git clone https://github.com/Ignyra/Nvim ~/.config/nvim
```

### Windows

Download nvim and add to path (powershell):
```
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-win64.zip
mkdir "%USERPROFILE%\Program Files\Neovim"
tar -xf nvim-win64.zip --strip-components=1 -C "%USERPROFILE%\Program Files\Neovim"
$oldPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$newPath = $oldPath + ";%USERPROFILE%\Program Files\Neovim\bin"
[System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
```

Then clone the configs:
```
git clone https://github.com/Ignyra/Nvim %USERPROFILE%\AppData\Local\nvim
```

## Configuration
