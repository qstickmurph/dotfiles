local lib = require("lib")

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.xml",
  callback = function(args)
    if not lib.in_git_project("snmpsimulator", args.buf) then
      return
    end

    vim.bo.expandtab = false
  end,
})
