
local languages_config = {
  -- Current Format: { treesitter_name, mason_lspconfig_name, filetypes, commentsting (use (n)gcc or (v)gc), settings}
  { "lua", "lua_ls", {"lua"}, {"-- %s"}, {settings = {Lua = {diagnostics = {globals = {'vim'}},}}} },
  { "python", "pyright", {"python"}, {"# %s"}},
  { "javascript", "ts_ls", {"javascript"}, {"// %s"}},
  { "typescript", "ts_ls", {"typescript"}, {"// %s"}},
  { "html", "html", {"html"}, {"<!-- %s -->"}},
  { "css", "cssls", {"css"}, {"/* %s */"}},
  { "rust", "rust_analyzer", {"rust"}, {"// %s"} },
  { "c", "clangd", {"c"}, {"// %s"} },
  { "cpp", "clangd", {"cpp"}, {"// %s"}},
  {"asm", "asm_lsp", {"asm"}, {}},--require "plugins.other.asm",-- Needs external insallation of cargo},
  { "scala", "", {"scala", "sbt"}, {"// %s", "// %s"}}
}
local settings = {}
local languages = {}
local commentS = {}
local filetype_lookup = {}
for _, lang in ipairs(languages_config) do
  for i, file in ipairs(lang[3]) do
    languages[file] = lang[1]
    commentS[file] = lang[4][i]
    if lang[2] ~= "" then -- Only add Mason-compatible entries
      filetype_lookup[file] = lang[2]
      settings[file] = lang[5]
    end
  end
end




return {
  languages,
  settings,
  filetype_lookup,
  commentS
}
