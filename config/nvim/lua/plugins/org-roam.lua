return {
  "chipsenkbeil/org-roam.nvim",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
    },
  },
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require("org-roam").setup({
      directory = "~/Documents/notes/roam",
      -- optional
      org_files = {
        "~/Documents/notes",
      },
      database = {
        path = vim.fs.joinpath(vim.fn.stdpath('data'), 'org-roam');
        persist = true,
        update_on_save = true
      },
    })
  end
}
