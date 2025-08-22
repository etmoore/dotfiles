# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various development tools including:
- Neovim (init.lua and lua/ modules)
- Zsh with Oh-My-Zsh
- Remote clipboard utilities (pbcopy/pbpaste)
- Vimium browser extension settings
- CoC (Conqueror of Completion) settings

## Key Files and Structure

- `init.lua` - Main Neovim configuration using Lazy.nvim package manager
- `lua/user/` - Modular Neovim configuration files (keymaps, plugins, colorscheme, etc.)
- `.zshrc` - Zsh shell configuration with Oh-My-Zsh
- `oh-my-zsh/custom/` - Custom themes and plugins for Oh-My-Zsh
- `pbcopy`, `pbpaste` - Remote clipboard utilities for SSH sessions
- `Makefile` - Setup scripts for dotfiles (TODO: Fix syntax issues - mixing Make and shell syntax)

## Setup Commands

### Initial Setup
TODO: The Makefile targets need fixing before these commands will work properly
```bash
make copy_dotfiles        # Create symlinks for dotfiles to home directory
make install_dependencies # Install pbcopy/pbpaste on Linux and vim-plug
```

### Neovim Plugin Management
The configuration uses Lazy.nvim. Plugins are managed through:
- `:Lazy` - Open Lazy.nvim interface
- `:Lazy install` - Install plugins
- `:Lazy update` - Update plugins

## Remote Clipboard Setup

This repository includes configuration for clipboard sharing between macOS (local) and Linux (remote) over SSH:
1. On macOS: Configure LaunchAgents for pbcopy/pbpaste services (see README.md)
2. On Linux: The Makefile will symlink pbcopy/pbpaste scripts to ~/bin
3. SSH configuration requires RemoteForward ports 2224-2225

## Architecture Notes

### Neovim Configuration
- Uses Lazy.nvim for plugin management with lazy loading
- Modular configuration split into separate files under `lua/user/`
- Key plugins include:
  - Oil.nvim for file exploration
  - Telescope for fuzzy finding
  - LSP and completion setup via nvim-cmp
  - Treesitter for syntax highlighting
  - Copilot for AI assistance

### Shell Configuration
- Zsh configured with Oh-My-Zsh framework
- Custom theme "muse" located in `oh-my-zsh/custom/themes/`
- Includes zsh-autosuggestions plugin for command completion
- SSH auth socket management for tmux sessions