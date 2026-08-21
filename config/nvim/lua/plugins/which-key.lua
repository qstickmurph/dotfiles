return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
  opts = {
   keys = {
    scroll_down = "<c-j>",
    scroll_up = "<c-k>",
   },
   triggers = {
    { "<leader>", mode = { "n", "v" } },
    { "<C-w>", mode="n" },
   }
  },
  config = function(_, opts)
   local wk = require('which-key')
   wk.setup(opts)

   local keybinds = require('config.keybinds')
   wk.add(keybinds)
  end
 }
