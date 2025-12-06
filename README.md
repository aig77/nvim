# Neovim Configuration

Lightning-fast Neovim config with LSP support for Nix, Rust, Python, and Go.

## Philosophy

- **Flexible installation** - Use Mason, Nix, or language-specific tools
- **No auto-installers** - You control your tooling
- **Lightning fast** - Lazy loading, no unnecessary overhead
- **Works everywhere** - Nix and non-Nix systems use the same config

## Installation

### 1. Clone Configuration

```bash
git clone <your-repo> ~/.config/nvim
```

### 2. Install LSP Servers

**Choose your preferred method** - all work seamlessly:

#### Option A: Mason (Easiest, works everywhere)

1. Launch Neovim
2. Run `:Mason`
3. Install what you need: `lua_ls`, `rust_analyzer`, `pyright`, `gopls`

**Note**: `nixd` is not available in Mason. For Nix support, install via Nix (see below).

#### Option B: Nix (Recommended for Nix users)

```bash
# Install all LSP servers and tools
nix profile install \
  nixpkgs#lua-language-server \
  nixpkgs#nixd \
  nixpkgs#rust-analyzer \
  nixpkgs#pyright \
  nixpkgs#gopls \
  nixpkgs#alejandra \
  nixpkgs#statix \
  nixpkgs#stylua \
  nixpkgs#rustfmt \
  nixpkgs#black \
  nixpkgs#ruff \
  nixpkgs#gofumpt \
  nixpkgs#gotools \
  nixpkgs#golangci-lint
```

Or add to your `home.nix`:

```nix
home.packages = with pkgs; [
  lua-language-server
  nixd
  rust-analyzer
  pyright
  gopls
  alejandra
  statix
  stylua
  rustfmt
  black
  ruff
  gofumpt
  gotools
  golangci-lint
];
```

#### Option C: Language-Specific Package Managers

```bash
# Rust
rustup component add rust-analyzer rustfmt clippy

# Python
pip install pyright ruff black

# Go
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Lua (if not using Mason or Nix)
# Download from GitHub releases or use your system package manager
```

#### Option D: Mix & Match

Totally fine! The config automatically uses whichever tools are in your PATH. For example:
- Install Rust tools via `rustup`
- Install Python tools via `pip`
- Install Nix tools via Nix
- Use Mason for everything else

PATH priority ensures manually installed tools take precedence over Mason.

### 3. Verify Installation

Launch Neovim and run:

```vim
:checkhealth
```

This will show which LSP servers and tools are available.

## Supported Languages

| Language | LSP | Formatters | Linters | Mason Support |
|----------|-----|------------|---------|---------------|
| **Nix** | nixd | alejandra | statix | ❌ Manual only |
| **Rust** | rust-analyzer | rustfmt | clippy | ✅ Yes |
| **Python** | pyright | black, ruff | ruff | ✅ Yes |
| **Go** | gopls | gofumpt, goimports | golangci-lint | ✅ Yes |
| **Lua** | lua_ls | stylua | - | ✅ Yes |

## Developing This Config

The `shell.nix` is only for developing the Neovim configuration itself (not for LSP servers):

```bash
cd ~/.config/nvim
nix-shell  # Provides lua, stylua, luacheck for config development

# Format the config
stylua .

# Lint the config
luacheck . --globals vim
```

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
- **mason.nvim** - Optional LSP installer (lazy loaded)
- **mason-lspconfig** - Mason integration with lspconfig
- **nvim-lspconfig** - LSP client configurations
- **cmp-nvim-lsp** - LSP completion source
- **none-ls** - Formatting and diagnostics

### Language Servers (installed separately)
- **lua_ls** - Lua
- **nixd** - Nix (with Home Manager and flake support)
- **rust_analyzer** - Rust (with clippy, inlay hints, proc macros)
- **pyright** - Python
- **gopls** - Go

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

- ⚡ **Lightning fast** - Mason lazy loads, zero overhead if tools pre-installed
- 🎯 **Auto-format on save** - All supported languages
- 💡 **Inlay hints** - Rust and Nix type hints
- 🔍 **Telescope integration** - File search, grep, Nix options, help tags
- 🌳 **Neo-tree** - File explorer with icons
- ✨ **Smart completion** - LSP-powered with snippets
- 🎨 **Beautiful UI** - Catppuccin theme, rounded borders, diagnostic icons
- 📦 **Flexible tooling** - Mason, Nix, or manual installation - your choice
