
local languages_config = {
  -- Format: { treesitter_name, mason_name, filetypes }
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  { "lua", "lua_ls", {"lua"}},
  { "python", "pyright", {"python"} },
  { "javascript", "ts_ls", {"javascript"} },
  { "typescript", "ts_ls", {"typescript"} },
  { "html", "html", {"html"} },
  { "css", "cssls", {"css"} },
  { "rust", "rust_analyzer", {"rust"} },
  {"asm", "asm_lsp", {"asm"}},--require "plugins.other.asm",-- Needs external insallation of cargo},
  { "scala", "", {}}
}
local servers = {}
local languages = {}
local filetype_lookup = {}
for _, lang in ipairs(languages_config) do
  for _, file in ipairs(lang[3]) do
    languages[file] = lang[1]
    if lang[2] ~= "" then
      table.insert(servers, lang[2])  -- Only add Mason-compatible entries
      filetype_lookup[file] = lang[2]
    end
  end
end




return {
  languages,
  servers,
  filetype_lookup
  
}
