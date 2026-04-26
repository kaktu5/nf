local M = {}

M.lsp = function()
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
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
  })
  vim.lsp.enable("lua_ls")
end

return M
