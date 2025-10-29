return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      css = { "stylelint" },
      bash = { "shellcheck" },
      yaml = { "yamllint" },
    }
  end
}
