local filetypes = { "lua" }

return {
  lsp = {
    lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = filetypes,
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

  lint = {
    filetypes = filetypes,
    linters = { "selene" },
  },

  fmt = {
    filetypes = filetypes,
    formatters = { "stylua" },
  },
}
