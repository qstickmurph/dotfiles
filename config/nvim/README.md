# Neovim Setup

## Config
All non-plugin configuration is in lua/config

## Plugins
All lazy.nvim plugins are defined in lua/plugins

### Package Manager
- [x] lazy.nvim: Neovim Package Manager
- [x] mason: LSP / Linter / Debugger Package manager
  - [x] mason-tool-installer: Defines mason tools to ensure installed

### Themes
- [x] gruvbox: Overall nvim theme

### File Navigation & Management
- [x] neo-tree.nvim: 
- [x] telescope: 
- [x] spectre.nvim
- [x] bookmarks.nvim: 
- [x] oil.nvim:

### Syntax/Treesitter
- [x] treesitter: 
- [x] nvim-treesitter-context: 
- [ ] nvim-treesitter-textobjects: 
- [ ] nvim-ts-autotag: 
- [x] mini.ai: 

### Auto-completion
- [x] blink.cmp: Completion Engine

### LSP
- [x] nvim-lspconfig: 

### Linting
- [x] nvim-lint:

### Formatting
- [x] conform: 

### Debugging
- [x] nvim-dap: 
- [x] nvim-dap-ui: 
- [x] nvim-dap-virtual-text: 

### Git
- [x] fugitive: 
- [x] gitsigns.nvim: 
- [x] git-blame.nvim: 

### Code Editing
- [ ] nvim-autopairs: 
- [ ] comment.nvim: 
- [ ] nvim-surround: 
- [ ] undotree:
- [x] refactoring.nvim: 
- [ ] vim-repeat
- [ ] flash.nvim: 
- [ ] todo-comments.nvim: 
- [ ] vim-sleuth: 

### Notes
- [x] neorg:
- [x] render-markdown.nvim: 
- [ ] vim-table-mode: 

### UI Enhancements
- [ ] lualine.nvim: 
- [ ] indent-blankline.nvim: 
- [ ] which-key.nvim: Keybinds displayer
- [ ] trouble.nvim: 
- [ ] dressing.nvim:
- [ ] nvim-notify: 
- [ ] aerial.nvim:
- [ ] zen-mode.nvim:
- [ ] nvim-ufo:
- [ ] smartcolumn.nvim:
- [ ] nvim-colorizer:

## Keybinds
The leader key used in nearly all my custom nvim keybinds is <SPACE>
Also, "jh" is mapped to <ESC>

The following prefixes are defined for keybinds:
- <Leader>p - File Navigation / File Tree
- <Leader>g - Git
- <Leader>n - Neorg
- <Leader>l - Lsp
- <Leader>L - Linter
- <Leader>f - Formatter
- <Leader>d - Debugger
