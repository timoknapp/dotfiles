#!/bin/sh

echo "Setting Do Not Disturb (Focus) automation..."

# Copy config/dndwatcher/com.timoknapp.dndwatcher.plist to ~/Library/LaunchAgents
cp "$HOME/.dotfiles/config/dndwatcher/com.timoknapp.dndwatcher.plist" "$HOME/Library/LaunchAgents/com.timoknapp.dndwatcher.plist"

# Replace HOMEDIR_PLACEHOLDER with your home directory
sed -i '' "s|HOMEDIR_PLACEHOLDER|$HOME|g" "$HOME/Library/LaunchAgents/com.timoknapp.dndwatcher.plist"

# Load the LaunchAgent
launchctl load "$HOME/Library/LaunchAgents/com.timoknapp.dndwatcher.plist"