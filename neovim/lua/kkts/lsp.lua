vim.lsp.config("*", {
  root_markers = { ".jj", "flake.nix" },
})

vim.lsp.enable({
  "lua_ls",
  "nixd",
  "rust_analyzer",
  "tinymist",
})
