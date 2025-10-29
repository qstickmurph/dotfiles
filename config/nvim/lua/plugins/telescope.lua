return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim'
  },
  config = function ()
    require('telescope').setup{
      defaults = { 
        file_ignore_patterns = { 
          "node_modules",
          ".git",
          "dist",
          "obj",
          "bin"
        }
      }
    }
    require("telescope").load_extension("undo")
  end
}
