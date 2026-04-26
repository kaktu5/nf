require("direnv").setup({
  autoload_direnv = true,

  keybindings = {
    allow = "<leader>da",
    deny = "<leader>dd",
    edit = "<leader>de",
    reload = "<leader>dr",
  },

  notifications = { level = vim.log.levels.INFO },
})
