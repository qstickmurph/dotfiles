return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "<C-w>", mode="n" },
    }
  },
  config = function()
    local wk = require('which-key')
    local keybinds = require('config.keybinds')

    wk.add(keybinds)
  end
}
