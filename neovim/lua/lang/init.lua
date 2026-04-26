local langs = {
  "lua",
}

for _, name in ipairs(langs) do
  local ok, lang = pcall(require, "lang." .. name)
  if ok and lang.lsp then lang.lsp() end
end
