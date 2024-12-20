# ⚡ Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](http://www.lua.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

<img src="./static/animation.gif" alt="Neovim Configuration Demo" width="600px" />

> "A well-crafted toolset is like a finely tuned instrument – powerful, responsive, and a joy to use."

</div>

## ✨ Features

<details open>
<summary><b>🎯 Key Highlights</b></summary>

- 🎨 **Beautiful UI**
  - Custom dashboard with ASCII art and animations
  - Modern and minimal status line
  - Smooth scrolling and animations
  
- ⚡ **Enhanced Editing**
  - Advanced syntax highlighting with Treesitter
  - Smart autocompletion
  - AI-powered coding assistance
  
- 🔍 **Powerful Search**
  - Fuzzy finding for files and text
  - Live grep with preview
  - Symbol navigation
  
- 🛠️ **Developer Tools**
  - Git integration with diff view
  - LSP support with diagnostics
  - Debugging capabilities
  
- ⌨️ **Efficient Workflow**
  - Intuitive key bindings
  - Quick file navigation
  - Smart splits management

</details>

## 📁 Directory Structure

<details>
<summary>Click to expand</summary>

```
.
├── 📁 lua/                    Main configuration directory
│   ├── 📁 configs/           Core configuration
│   │   ├── 🔧 autocommands   Auto commands and events
│   │   ├── 🎨 colorscheme    Theme and colors
│   │   ├── 🛠️  common        Shared utilities
│   │   ├── ⌨️  keymaps       Global key bindings
│   │   └── ⚙️  options       Neovim settings
│   │
│   └── 📁 plugins/           Plugin configurations
│       ├── 📝 editor/        Text editing enhancements
│       │   ├── mini          Essential tools (surround, ai)
│       │   ├── autopairs     Smart bracket pairing
│       │   └── ...
│       │
│       ├── 🛠️ tools/         Productivity tools
│       │   ├── 🤖 ai/        AI assistants
│       │   │   ├── avante    AI code assistance
│       │   │   └── copilot   GitHub Copilot
│       │   ├── finders       Fuzzy finding
│       │   ├── which-key     Keybinding helper
│       │   └── ...
│       │
│       └── 🎯 ui/            User interface
│           ├── lualine       Status line
│           ├── neo-tree      File explorer
│           ├── notify        Notifications
│           └── snacks        Dashboard
│
├── 📜 init.lua               Entry point
├── 🛠️ scripts/              Utility scripts
└── 🖼️ static/               Assets and images
```

</details>

## 🔌 Core Plugins

<details>
<summary><b>View Plugin List</b></summary>

| Category | Plugin | Description |
|----------|--------|-------------|
| **🎨 UI** |
| | [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) | Modern file explorer |
| | [Lualine](https://github.com/nvim-lualine/lualine.nvim) | Fast statusline |
| | [Notify](https://github.com/rcarriga/nvim-notify) | Notification manager |
| | [Snacks](https://github.com/simrat39/snacks.nvim) | Beautiful dashboard |
| **📝 Editor** |
| | [Mini.nvim](https://github.com/echasnovski/mini.nvim) | Essential editing tools |
| | [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| | [Autopairs](https://github.com/windwp/nvim-autopairs) | Bracket pairing |
| **🛠️ Tools** |
| | [Which-key](https://github.com/folke/which-key.nvim) | Command helper |
| | [Telescope](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| | [Harpoon](https://github.com/ThePrimeagen/harpoon) | File navigation |
| | [OSCYank](https://github.com/ojroques/vim-oscyank) | System clipboard |
| **🤖 AI** |
| | [Copilot](https://github.com/github/copilot.vim) | GitHub Copilot |
| | [Avante](https://github.com/simrat39/avante.nvim) | AI assistance |
| **📦 Git** |
| | [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| | [Diffview](https://github.com/sindrets/diffview.nvim) | Git diff viewer |

</details>

## ⚡ Quick Start

### Prerequisites

> ⚠️ **Important Note for Ubuntu Users**: The default Neovim package in Ubuntu's standard repositories is outdated. This configuration requires Neovim >= 0.9.0 for full functionality, as many plugins use newer APIs. You **must** install Neovim from the unstable PPA.

<details>
<summary><b>View Dependencies</b></summary>

Required:
- neovim >= 0.9.0 (required for plugin compatibility)
- git
- ripgrep (for telescope)
- fd-find (for telescope)
- nodejs >= 16 (for copilot)
- python3
- markdownlint-cli (for markdown linting)

Optional:
- cmatrix (for animations)
- nodejs (for LSP features)
- cargo (for certain tools)

</details>

### Installation

<details>
<summary><b>Ubuntu/Debian</b></summary>

```bash
# Add neovim unstable PPA (REQUIRED for Ubuntu)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update

# Verify neovim version after installation
nvim --version  # Should be >= 0.9.0

# Install system dependencies
sudo apt install neovim git ripgrep fd-find cmatrix python3 python3-pip nodejs npm

# Install markdownlint-cli using npm
npm install -g markdownlint-cli
```

</details>

<details>
<summary><b>Other Linux Distributions</b></summary>

Ensure Neovim >= 0.9.0 is installed:
- Arch Linux: `pacman -S neovim` (latest version in official repos)
- Fedora: `dnf install neovim` (usually up to date)
- Manual: [Neovim GitHub Releases](https://github.com/neovim/neovim/releases)

</details>

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - The perfect starting point for Neovim configuration
- [LazyVim](https://github.com/LazyVim/LazyVim) - Inspiration for plugin organization
- [LunarVim](https://github.com/LunarVim/LunarVim) - Ideas for keybindings and UI

---

<div align="center">
<p>Made with ❤️ by <a href="https://simayonthampi.me">Simayon Thampi</a></p>

[![portfolio](https://img.shields.io/badge/Portfolio-255E63?style=for-the-badge&logo=About.me&logoColor=white)](https://simayonthampi.me)
[![linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/simayonthampi)
[![github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/simayon)

</div>
