#!/bin/sh

echo "Setting VSCode preferences..."

# Copy VSCode settings
cp $DOTFILES_DIR/config/vscode/settings.json $HOME/Library/Application\ Support/Code/User

echo "VSCode will be restarted now!!"
killall Code
open /Applications/Visual\ Studio\ Code.app

