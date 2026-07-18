return {
  filetypes = { "nix" },

  lsp = {
    nixd = { cmd = { "nixd", "--semantic-tokens" } },
  },

  fmt = { "alejandra", "nixfmt", stop_after_first = true },
}
