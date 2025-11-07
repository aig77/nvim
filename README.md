# Neovim Configuration

Neovim config with LSP, completions, and Nix/Rust development support.

## Plugins

### UI & Theme
- **catppuccin** - Color scheme
- **lualine** - Status line with catppuccin theme
- **dashboard** - Start screen
- **nvim-web-devicons** - File icons

### Navigation
- **telescope** - Fuzzy finder for files, grep, buffers, help tags
- **telescope-manix** - Search Nix/Home Manager options
- **neo-tree** - File explorer
- **vim-tmux-navigator** - Navigate between tmux panes and vim splits

### Editing
- **Comment.nvim** - Toggle comments
- **treesitter** - Syntax highlighting and parsing
- **nvim-cmp** - Autocompletion
- **LuaSnip** - Snippet engine

### LSP & Development
- **nvim-lspconfig** - LSP client configurations
- **cmp-nvim-lsp** - LSP completion source
- **none-ls** - Formatting and diagnostics (alejandra, statix, stylua, rustfmt, ruff, black)

### Language Servers
- **lua_ls** - Lua
- **nixd** - Nix (with Home Manager and flake support)
- **rust_analyzer** - Rust (with clippy, inlay hints, proc macros)
- **pyright** - Python

## Keybindings

### General
- `<Space>` - Leader key

### File Navigation
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fn` - Search Nix options

### Comments
- `<leader>/` - Toggle line comment (normal & visual)
- `<leader>cb` - Toggle block comment (normal & visual)

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - List references
- `K` - Hover documentation
- `<C-k>` - Signature help
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>f` - Format buffer
- `<leader>th` - Toggle inlay hints
- `gl` - Line diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### Clipboard
- `<leader>y` - Copy to system clipboard
- `<leader>Y` - Copy line to system clipboard
- `<leader>ya` - Copy entire buffer to system clipboard
- `<leader>p` - Paste from system clipboard
- `<leader>P` - Paste before cursor from system clipboard

## Features

- Auto-format on save
- Inlay hints for Rust and Nix
- Home Manager and NixOS option completion
- Diagnostic icons and rounded borders
- Pre-commit hooks for formatting and linting
