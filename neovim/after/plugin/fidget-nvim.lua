local fidget = require("fidget")

fidget.setup({
  notification = {
    override_vim_notify = true,
    window = { winblend = 100 },
  },
})

vim.keymap.set("n", "<leader>fcc", fidget.notification.clear)
vim.keymap.set("n", "<leader>fch", fidget.notification.clear_history)
vim.keymap.set("n", "<leader>fh", "<cmd>Fidget history<cr>")
