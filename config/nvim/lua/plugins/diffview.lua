return {
  "dlyongemallo/diffview-plus.nvim",
  version = "*",
  cmd = {
    "DiffviewOpen",
    "DiffviewToggle",
    "DiffviewFileHistory",
    "DiffviewDiffFiles",
    "DiffviewLog",
  },
  opts = {
    view = {
      default = {
        layout = "diff1_inline",
      },
      file_panel = {
        win_config = {
          position = 'left',
          width = 50
        }
      }
    },
    inline = {
      style = "unified", -- vs "overleaf"
    },
  },
  config = function(_, opts)
    require('diffview').setup(opts)

    vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { bg = "#2b3320" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = "#3c1f1e" })
    vim.api.nvim_set_hl(0, "DiffviewDiffTextInline", { bg = "#3a3320" })
  end,
}
