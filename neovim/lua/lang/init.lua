vim.lsp.config("*", {
  root_markers = { ".jj", "flake.nix" },
})

local langs = {
  "lua",
  "nix",
  "rust",
}

local linters_by_ft = {}
local formatters_by_ft = {}

for _, name in ipairs(langs) do
  local ok, lang = pcall(require, "lang." .. name)
  if not ok then goto continue end

  if lang.lsp then
    for name, config in pairs(lang.lsp) do
      config.filetypes = lang.filetypes
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end
  end

  if lang.lint then
    for _, ft in ipairs(lang.filetypes) do
      linters_by_ft[ft] = lang.lint
    end
  end

  if lang.fmt then
    for _, ft in ipairs(lang.filetypes) do
      formatters_by_ft[ft] = lang.fmt
    end
  end

  ::continue::
end

return {
  linters_by_ft = linters_by_ft,
  formatters_by_ft = formatters_by_ft,
}
