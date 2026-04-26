return {
  filetypes = { "lua" },

  lsp = {
    lua_ls = {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
          hint = { enable = true },
          codeLens = { enable = true },
        },
      },
    },
  },

  lint = { "selene" },

  fmt = { "stylua" },
}
