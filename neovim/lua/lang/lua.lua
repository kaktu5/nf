return {
  filetypes = { "lua" },

  lsp = {
    lua_ls = { cmd = { "lua-language-server" } },
  },

  lint = { "selene" },

  fmt = { "stylua" },
}
