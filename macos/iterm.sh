#!/bin/sh

echo "Setting iTerm2 preferences..."

# Copy iTerm2 Profile
cp $DOTFILES_DIR/config/iterm2/profile.json $HOME/Library/Application\ Support/iTerm2/DynamicProfiles

defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "7194E672-938C-4FEE-B3C9-08E46AEAEABC"
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 1

echo "iTerm2 will be restarted now!!"
killall iTerm2
open /Applications/iTerm.app

