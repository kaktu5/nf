local langs = {
  "lua",
}

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

  if lang.fmt then
    for _, ft in ipairs(lang.fmt.filetypes) do
      formatters_by_ft[ft] = lang.fmt.formatters
    end
  end

  ::continue::
end

return { formatters_by_ft = formatters_by_ft }
