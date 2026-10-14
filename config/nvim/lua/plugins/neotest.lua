return {
  "nvim-neotest/neotest",
  tag = "v5.14.0",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Testing Adapters
    "nsidorenco/neotest-vstest",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {},
      discovery = {
        enabled = true,
        concurrent = 8,
        filter_dirs = { "node_modules", ".git", "bin", "obj", "src" },
      },
      output = {
        open_on_run = true,
      },
      summary = {
        animated = true,
      },
    })
  end
}
