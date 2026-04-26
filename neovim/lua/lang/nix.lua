local filetypes = { "nix" }

return {
  lsp = {
    nixd = {
      filetypes = filetypes,
      cmd = { "nixd", "--semantic-tokens=true" },
    },
  },

  lint = {
    filetypes = filetypes,
    linters = { "deadnix", "statix" },
  },

  fmt = {
    filetypes = filetypes,
    formatters = { "alejandra", "nixfmt", stop_after_first = true },
  },
}
