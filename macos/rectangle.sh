#!/bin/sh

echo "Setting Rectangle preferences..."

defaults write com.knollsoft.Rectangle gapSize -float 3
defaults write com.knollsoft.Rectangle almostMaximizeHeight -float .98
defaults write com.knollsoft.Rectangle almostMaximizeWidth -float .98
defaults write com.knollsoft.Rectangle launchOnLogin -int 1

killall Rectangle
open /Applications/Rectangle.app