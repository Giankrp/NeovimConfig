# Neovim Config (Custom Kickstart)

[Leer en Español 🇪🇸](README.es.md)

A modern, modular, and blazing-fast Neovim configuration built on the new native LSP APIs in Neovim 0.11+.

## 🚀 Installation

To install this configuration, clone this repository into your Neovim configuration directory:

### Linux / macOS

```bash
git clone https://github.com/Giankrp/NeovimConfig ~/.config/nvim
```

### Windows (PowerShell - Recommended)

```bash
git clone https://github.com/Giankrp/NeovimConfig $env:LOCALAPPDATA\nvim
```

### Windows (cmd)

```bash
git clone https://github.com/Giankrp/NeovimConfig %LOCALAPPDATA%\nvim
```

Then, simply open Neovim:

```bash
nvim
```

## ⚡ Express Setup on Windows (Recommended)

If you are on Windows, the cleanest and fastest way to install Neovim and all the necessary dependencies mentioned below (compilers, search engines, and environments) is using [Scoop](https://scoop.sh/).
The configuration will automatically detect missing plugins and tools via Mason and install them on the first run.

> [!WARNING]
> Always check the Scoop installation script in the official documentation (the link is in the text above) in case the installation script changes.

### Run in PowerShell

```bash
# 1. Install Scoop (if you don't have it)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# 2. Add required buckets
scoop bucket add extras

# 3. Install the entire environment (Core + Recommended tools)
scoop install neovim git zig ripgrep fd nodejs-lts go lazygit tree-sitter
```

## 📋 Requirements

### Mandatory (Core)

- **Neovim >= 0.11.0**: This configuration uses the new native LSP APIs that are only available in recent versions.
- **C Compiler**: Required for `nvim-treesitter` to compile language parsers (e.g., `gcc`, `clang`, or `zig`).
- **tree-sitter-cli**: Required by `nvim-treesitter` for parser generation and compilation.
  - *How to install*:
    - **npm**: `npm install -g tree-sitter-cli`
    - **Scoop (Windows)**: `scoop install tree-sitter`
    - **Homebrew (macOS)**: `brew install tree-sitter`
    - **Cargo**: `cargo install tree-sitter-cli`
- **Base Tools**: `git`, `curl`, `unzip`, `tar`, `gzip` (needed by Mason to download and install servers).

### Optional (Recommended for the best experience)

- **Nerd Font**: Required to see icons in the dashboard, statusline, and search windows (e.g., JetBrainsMono Nerd Font).
- **ripgrep (rg)**: For ultra-fast text searches via Snacks picker.
- **fd**: For faster file searches.
- **Node.js & npm/pnpm/yarn**: Required for web development language servers (TypeScript, Vue, Prettier).
- **Go**: Required for Go development and the `gopls` language server.
- **shell-color-scripts**: For the dashboard terminal to display colors correctly (`colorscript` command).
- **lazygit**: For the integrated Git terminal UI (`<leader>lg`).
- **OpenCode CLI**: Required if you want to use the AI integration (`opencode.nvim`).
  > [!WARNING]
  > **Performance on Windows / PowerShell**: Spawning the OpenCode server automatically from Neovim on Windows can cause latency (lag). It is highly recommended to start it manually in an external terminal by running `opencode --port 3000` and uncommenting the `server` option in `lua/plugins/extras/opencode.lua` to connect to it.

## 📁 Project Structure

- `init.lua`: Main entry point.
- `lua/config/`: Core settings (options, keymaps, autocommands, build hooks).
- `lua/plugins/`:
  - `lsp/`: Modular language server configurations (one file per server).
  - `snacks.lua`: Dashboard, picker, explorer, utilities.
  - `ui.lua`: Appearance, statusline, theme (Catppuccin).
  - `extras/`: Optional features (OpenCode, Autopairs, DAP, etc.).

## ⌨️ Key Keymaps

- `<leader>sf`: Search files.
- `<leader>sg`: Search text (Grep).
- `<leader>lg`: Open Lazygit.
- `<C-n>`: Toggle file explorer.
- `<C-a>`: Ask OpenCode AI.
- `<leader>bd`: Delete current buffer.
- `<leader>gb`: Open current file/lines on git host (GitHub/GitLab/etc.).
- `<leader>bs`: Toggle scratchpad buffer.
- `grr`: Go to references (LSP).
- `grn`: Rename symbol (LSP).

---

_Note: After installing, you can run `:checkhealth` inside Neovim to verify if any optional dependency is missing._
