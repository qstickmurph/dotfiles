return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "html", "css", "rust", "typescript", "javascript", "tsx", "dockerfile"},
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = false }
    })
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.treesitter.language.register('dockerfile', { 'Containerfile', 'Dockerfile' })
  end
}
