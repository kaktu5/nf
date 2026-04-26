local formatters_by_ft = require("lang").formatters_by_ft

return {
  "conform.nvim",

  cmd = { "ConformInfo" },

  ft = vim.tbl_keys(formatters_by_ft),

  keys = {
    { "<leader>f", function() require("conform").format({ async = true }) end },
  },

  after = function()
    require("conform").setup({
      formatters_by_ft = require("lang").formatters_by_ft,
    })
  end,
}
