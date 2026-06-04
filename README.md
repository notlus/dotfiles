# dotfiles

Personal development environment for macOS, optimized for Swift/Xcode development with Neovim as the primary editor. Unified [Tokyo Night](https://github.com/folke/tokyonight.nvim) theme across all tools.

## What's Included

### Terminal & Shell

| Tool | Description |
|------|-------------|
| [zsh](zsh/) | Shell config with oh-my-zsh (git, macos, swiftpm, xcode plugins) |
| [tmux](tmux/) | Terminal multiplexer with vi-mode and vim-aware pane navigation |
| [starship](starship/) | Starship prompt (Tokyo Night theme) |
| [WezTerm](wezterm/) | GPU-accelerated terminal with smart pane splitting |
| [Ghostty](ghostty/) | Terminal emulator (Tokyo Night Moon theme) |

### Neovim

Extensive [Neovim configuration](vim/.config/nvim/) using [lazy.nvim](https://github.com/folke/lazy.nvim) with 36+ plugins:

- **Xcode Integration** — Build, run, and test iOS projects via [xcodebuild.nvim](https://github.com/wojciech-kulik/xcodebuild.nvim)
- **LSP** — sourcekit (Swift), clangd (C/C++), pyright (Python), lua_ls (Lua), bashls (Bash)
- **Completion** — [blink.cmp](https://github.com/Saghen/blink.cmp) with LSP, snippets, path sources, and a custom [LM Studio source](vim/.config/nvim/lua/blink-cmp-lmstudio.lua) for local model completions
- **AI** — CodeCompanion (named profiles), Copilot, Supermaven, Amazon Q, LM Studio (local Qwen 2.5 Coder)
- **Debugging** — DAP with DAP-UI for integrated debugging
- **Navigation** — Telescope, Harpoon, flash.nvim
- **Git** — Gitsigns, git-blame, LazyGit integration
- **UI** — Noice, Snacks, mini.files, lualine

### Editors

| Tool | Description |
|------|-------------|
| [Zed](zed/) | Code editor with vim mode, Tokyo Night theme, Claude Opus 4.6 AI |

### Window Management & macOS

| Tool | Description |
|------|-------------|
| [Aerospace](aerospace/) | Tiling window manager |
| [SketchyBar](sketchybar/) | Custom menu bar (volume, calendar, battery, spaces, front app) |
| [Karabiner](karabiner/) | Keyboard remapping (Hyper key, app/raycast/window layers) |
| [leader-key](leader-key/) | Keyboard-driven launcher (apps, Raycast, windows, search, profiles) |
| [Flashspace](flashspace/) | Workspace profiles (nebula, nova, pulsar, pumpkin) |

### Git & Dev Tools

| Tool | Description |
|------|-------------|
| [lazygit](lazygit/) | Git UI with delta pager |
| [bat](bat/) | Syntax-highlighted `cat` replacement |
| [eza](eza/) | Modern `ls` replacement |
| [yazi](yazi/) | Terminal file manager |
| [lldb](lldb/) | Debugger configuration |

### Code Formatting

| Tool | Description |
|------|-------------|
| [clang-format](formatting/.clang-format) | C/C++ formatting |
| [swiftformat](formatting/.swiftformat) | Swift formatting |

### Package Management

[Brewfile](homebrew/Brewfile) with 60+ packages including CLI tools, cask applications, and Mac App Store apps.

## Setup

```sh
# Clone the repo
git clone https://github.com/<user>/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles

# Install Homebrew packages
brew bundle --file=homebrew/Brewfile

# Symlink configs to home directory
./scripts/bootstrap
```

The bootstrap script creates symlinks from dotfiles into your home directory, backing up any existing files first.

## Key Design Decisions

- **Vim-aware navigation everywhere** — Tmux, WezTerm, and Neovim share seamless pane/split navigation with consistent keybindings
- **Tokyo Night theme** — Consistent color scheme across Neovim, terminals, bat, eza, lazygit, and sketchybar
- **Keyboard-first workflow** — Leader-key app launcher, Aerospace tiling, Karabiner remapping, and 80+ custom Neovim keymaps
- **Swift/iOS focused** — Xcode build integration, sourcekit LSP, Swift formatting, and test runner all accessible from Neovim
