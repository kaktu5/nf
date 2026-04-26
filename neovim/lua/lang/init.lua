local langs = {
  "lua",
  "nix",
}

local linters_by_ft = {}
local formatters_by_ft = {}

for _, name in ipairs(langs) do
  local ok, lang = pcall(require, "lang." .. name)
  if not ok then goto continue end

  if lang.lsp then
    for name, config in pairs(lang.lsp) do
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end
  end

  if lang.lint then
    for _, ft in ipairs(lang.lint.filetypes) do
      linters_by_ft[ft] = lang.lint.linters
    end
  end

  if lang.fmt then
    for _, ft in ipairs(lang.fmt.filetypes) do
      formatters_by_ft[ft] = lang.fmt.formatters
    end
  end

  ::continue::
end

return {
  linters_by_ft = linters_by_ft,
  formatters_by_ft = formatters_by_ft,
}
