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
    "nvim-neotest/neotest-python",
  },
  config = function()
    vim.g.neotest_vstest = {
      discovery_directory_filter = function(search_path)
        -- ignore hidden directories
        return search_path:match("/tests")
      end,
      broad_recursive_discovery = false,
    }

    require("neotest").setup({
      adapters = {
        require("neotest-vstest"),
        require("neotest-python"),
      },
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
