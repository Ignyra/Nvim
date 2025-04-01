
local languages_config = {
  -- Format: { treesitter_name, mason_name, lsp_settings }
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  { "lua", "lua_ls", {
      settings = {
        Lua = { diagnostics = { globals = { "vim" } } }
      }
    }
  },
  { "python", "pyright", {} },
  { "javascript", "ts_ls", {} },
  { "typescript", "ts_ls", {} },
  { "html", "html", {} },
  { "css", "cssls", {} },
  { "rust", "rust_analyzer", {} },
  {"asm", "asm_lsp", {require "plugins.other.asm",-- Needs external insallation of cargo
    }
  },
  { "scala", "", {}}
}

local languages = {}
for _, lang in ipairs(languages_config) do
  table.insert(languages, lang[1])
end

local servers = {}
for _, lang in ipairs(languages_config) do
  if lang[2] ~= "" then
    table.insert(servers, lang[2])  -- Only add Mason-compatible entries
  end
end

local opts_lookup = {}
for _, lang in ipairs(languages_config) do
  if lang[2] ~= "" then -- Use Mason name if available
    opts_lookup[lang[2]] = lang[3]
  end
end

return {
  languages,
  servers,
  opts_lookup
}
