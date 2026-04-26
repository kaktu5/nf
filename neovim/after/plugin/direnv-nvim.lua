require("direnv").setup({
  autoload_direnv = true,

  keybindings = {
    allow = "<Leader>da",
    deny = "<Leader>dd",
    edit = "<Leader>de",
    reload = "<Leader>dr",
  },

  notifications = { level = vim.log.levels.INFO },
})
