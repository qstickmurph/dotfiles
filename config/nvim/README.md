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
- [x] Snacks tree: 
- [x] spectre.nvim
- [x] bookmarks.nvim: 

### Syntax/Treesitter
- [x] treesitter: 
- [x] nvim-treesitter-context: 
- [x] nvim-treesitter-textobjects: 
- [x] nvim-ts-autotag: 
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
- [x] nvim-autopairs: 
- [x] comment.nvim: 
- [x] nvim-surround: 
- [x] undotree:
- [x] refactoring.nvim: 
- [x] flash.nvim: 
- [x] todo-comments.nvim: 

### Notes
- [x] neorg:
- [x] render-markdown.nvim: 

### UI Enhancements
- [x] lualine.nvim: 
- [x] indent-blankline.nvim: 
- [x] which-key.nvim: Keybinds displayer
- [x] trouble.nvim: 
- [x] snacks.nvim: 
- [x] aerial.nvim:
- [x] nvim-colorizer:

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
