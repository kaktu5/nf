return {
  "conform.nvim",

  cmd = { "ConformInfo" },

  keys = {
    { "<leader>f", function() require("conform").format({ async = true }) end },
  },

  after = function()
    require("conform").setup({
      formatters_by_ft = require("lang").formatters_by_ft,
    })
  end,
}
