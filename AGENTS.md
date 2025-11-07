# Agent Guidelines for Neovim Configuration

## Linting & Formatting
- **Lua**: `stylua` (format), `luacheck init.lua ./lua --globals vim` (lint)
- **Nix**: `alejandra` (format), `statix check --format errfmt` (lint)
- Pre-commit hooks run automatically via `.pre-commit-config.yaml` (managed by Nix)

## Code Style
- **Indentation**: 2 spaces (no tabs), set via `vim.opt.expandtab/tabstop/shiftwidth`
- **Plugin structure**: Each plugin in `lua/plugins/*.lua` returns a lazy.nvim spec table
- **LSP servers**: Configured in `lua/plugins/lsp.lua` - add to `servers` array
- **LSP enhancements**: Inlay hints enabled by default; toggle with `<leader>th`
- **Nix LSP**: Uses `nixd` (not nil_ls) for Home Manager and flake option support
- **Nix options search**: Use `<leader>fn` to search NixOS/Home Manager options via telescope-manix
- **Globals**: `vim` is the only global allowed (for Neovim API)
- **Formatting**: Auto-format on save enabled; manual format with `<leader>f`

## Naming Conventions
- Files: lowercase with hyphens (e.g., `vim-options.lua`, `neo-tree.lua`)
- Variables: snake_case (e.g., `lsp_keymaps`, `on_attach`)
- Functions: snake_case for local, follow plugin conventions for configs

## Architecture
- Entry: `init.lua` → loads `vim-options.lua` → lazy.nvim loads `lua/plugins/*.lua`
- Each plugin file returns a lazy.nvim plugin spec with `config` function
- Keymaps use `vim.keymap.set()` with descriptive `desc` field
- LSP/formatting setup uses conditional checks (`vim.fn.executable()`) for availability

## Testing
- No automated tests in this config (manual testing via Neovim)
- Verify: Launch `nvim`, check `:checkhealth`, ensure plugins load without errors
