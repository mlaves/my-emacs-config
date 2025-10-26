# Minimal Emacs Configuration

My Emacs 30 setup without bloat.

## Features

- **Modern UI**: Clean interface with syntax highlighting, line numbers, and a dark theme
- **Smart Completion**: Vertico + Orderless + Marginalia for fast, fuzzy searching
- **Code Intelligence**: Company for auto-completion, Flymake for syntax checking
- **Better Navigation**: Consult for enhanced buffer/file switching and searching
- **Quality of Life**: Which-key for keybinding hints, undo-tree for better undo/redo, rainbow delimiters

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/emacs-config.git ~/.emacs.d
   ```

2. Start Emacs. Packages will install automatically on first launch.

## Key Bindings

- `C-x b` - Smart buffer switching (consult-buffer)
- `C-c r` - Recent files (consult-recent-file)
- `C-c g` - Grep search in project (consult-grep)
- `Shift+arrows` - Move between windows

## Requirements

- Emacs 30 or later
- Internet connection for initial package installation

## Customization

Edit `init.el` to adjust settings. The configuration uses `use-package` for clean, declarative package management.

## License

Free to use and modify as you wish.
