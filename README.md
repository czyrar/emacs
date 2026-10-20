# My Emacs conf

This is my GNU Emacs configuration.

## Requirements

- `git`

- `emacs` `v31` or above

- `tree-sitter` [[INSTALL](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)]

### Arch requisites install (not the font)

```sh
# If on Wayland
sudo pacman -S git emacs-wayland tree-sitter-cli
# If on X11
sudo pacman -S git emacs tree-sitter-cli
```

## Installing

```sh
# Required
mv ~/.config/emacs{,.bak}

# Install
git clone https://github.com/czyrar/emacs.git ~/.config/emacs
```
