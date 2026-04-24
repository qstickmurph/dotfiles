return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      _ = { "cspell" },
      lua = { "luacheck" },
      css = { "stylelint" },
--      html = { "htmlhint" },
      bash = { "shellcheck" },
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      callback = function()
        vim.env.ESLINT_D_PPID = vim.fn.getpid()
        require("lint").try_lint()

        vim.api.nvim_create_user_command("LintInfo", function()
          local filetype = vim.bo.filetype
          local linters = require("lint").linters_by_ft[filetype]

          if linters then
            print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
          else
            print("No linters configured for filetype: " .. filetype)
          end
        end, {})
      end,
    })
  end,
}
