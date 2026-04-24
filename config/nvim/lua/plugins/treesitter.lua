return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local ts = require("nvim-treesitter")

    -- Install parsers (runs async; :wait() blocks until done at startup)
    ts.install({
      "lua",
      "vim",
      "vimdoc",
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
      "c_sharp",
      "java",
      "rust",
      "go",
      },
      { summary = false }
    )

    -- Register dockerfile parser for Containerfile/Dockerfile filetypes
    vim.treesitter.language.register("dockerfile", { "Containerfile", "Dockerfile" })

    -- Enable highlighting + folding per filetype via autocmd
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_features", { clear = true }),
      pattern = "*",
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match) or event.match

        -- Highlighting
        pcall(vim.treesitter.start, event.buf, lang)

        -- Folding
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })

    require('nvim-ts-autotag').setup({
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ["html"] = {
          enable_close = false
        }
      }
    })
  end,
}
