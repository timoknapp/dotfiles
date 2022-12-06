#!/bin/sh

echo "Setting TopNotch preferences..."

defaults write pl.maketheweb.TopNotch isEnabled -int 0
defaults write pl.maketheweb.TopNotch hideMenubarIcon -int 1
defaults write pl.maketheweb.TopNotch hideOnBuiltInOnly -int 1
defaults write pl.maketheweb.TopNotch roundCorners -int 0
defaults write pl.maketheweb.TopNotch useDynamicWallpapers -int 0

killall TopNotch
# open /Applications/TopNotch.app