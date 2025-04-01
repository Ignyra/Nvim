-- 
-- Set Vim options
-- Option docs are found by :help <option name>
-- Options list can be viewed by :help options_list
--


--Set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Shows mode besides the status bar
vim.opt.laststatus = 3
vim.opt.showmode = false

--Sets font
--vim.g.have_nerd_font = true


--Line numbers settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false

--Allows mouse mode; Allowes wrapping for movement keys
vim.opt.mouse = 'a'
vim.opt.whichwrap:append "<>[]hl"

--Set Indentation
vim.opt.breakindent = true
vim.opt.expandtab = true     --Use real tabs if false, else spaces
vim.opt.shiftwidth = 2       --Uses tabs and tabstop if 0 else real tabs and shiftwidth
vim.opt.autoindent = true
vim.opt.cpoptions:append "I" --Don't erase indentaion if cursor moved from a premade indentaion without editing it.
vim.opt.smartindent = true
vim.opt.tabstop = 8          --Defines how a tab will look like. Defualt is 8.


--Syncs OS clipboard with vim clipboard
--Schedule sets it after entering to not take time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'


-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Set to False if:
-- Instead of raise a dialog to confirm when when command fails due to unsaved changes, raise error.
vim.opt.confirm = false


--Sets how neovim will display certain whitespace characters in the editor.
--For the vertical column effect without tabs, use leadmultispace with n spaces.
--n = widthDesired -1
vim.opt.list = true
vim.opt.listchars = { tab = '▏ ', leadmultispace = '▏ ', trail = '·', nbsp = '␣' }

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0


vim.diagnostic.config({
  virtual_text = true,      -- inline errors
  signs = true,             -- signs in the gutter
  underline = true,         -- underline errors
  update_in_insert = false, -- update while typing
  severity_sort = true,
})
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
--vim.opt.ignorecase = true
--vim.opt.smartcase = true

--vim.opt.fillchars = { eob = " " }


