return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "norg",
      "norg-meta",
      "query",
      "python",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "dockerfile",
      "yaml",
      "c",
      "cpp",
      "csharp",
      "java",
      "rust",
      "golang",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = false },
    autotag = { enable = true },
  },
  config = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

    vim.treesitter.language.register('dockerfile', { 'Containerfile', 'Dockerfile' })
  end
}
