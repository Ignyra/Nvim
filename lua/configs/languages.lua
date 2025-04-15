
local languages_config = {
  -- Current Format: { treesitter_name, mason_lspconfig_name, filetypes, settings}
  { "lua", "lua_ls", {"lua"}, {settings = {Lua = {diagnostics = {globals = {'vim'}},}}} },
  { "python", "pyright", {"python"} },
  { "javascript", "ts_ls", {"javascript"} },
  { "typescript", "ts_ls", {"typescript"} },
  { "html", "html", {"html"} },
  { "css", "cssls", {"css"} },
  { "rust", "rust_analyzer", {"rust"} },
  { "c", "clangd", {"c"}},
  { "cpp", "clangd", {"cpp"}},
  { "c_sharp", "", {"cs"}}, 
  {"asm", "asm_lsp", {"asm"}},--require "plugins.other.asm",-- Needs external insallation of cargo},
  { "scala", "", {"scala", "sbt"}}
}
local settings = {}
local languages = {}
local filetype_lookup = {}
for _, lang in ipairs(languages_config) do
  for _, file in ipairs(lang[3]) do
    languages[file] = lang[1]
    if lang[2] ~= "" then -- Only add Mason-compatible entries
      filetype_lookup[file] = lang[2]
      settings[file] = lang[4]
    end
  end
end




return {
  languages,
  settings,
  filetype_lookup
  
}
