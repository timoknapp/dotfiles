#!/bin/sh

echo "Setting up workspace..."

XDG_CONFIG_HOME=~/.config

# Create Symlink for central .gitconfig
ln -s $XDG_CONFIG_HOME/git/config ~/.gitconfig

# Copy workspace template to $HOME directory
[[ -d "$HOME/workspace" ]] && echo "Workspace already exists." || cp -R $DOTFILES_DIR/config/git/workspace $HOME/workspace

# Copy .ssh folder
# SSH-Keys still need to be inserted
[[ -d "$HOME/.ssh" ]] && echo "ssh directory already exists." || cp -R $DOTFILES_DIR/config/ssh ~/.ssh