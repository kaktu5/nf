return {
  "indent-blankline.nvim",

  event = "DeferredUIEnter",

  after = function()
    require("ibl").setup({
      indent = { char = "│" },
      scope = { enabled = false },
    })
  end,
}
