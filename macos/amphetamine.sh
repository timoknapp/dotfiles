#!/bin/sh

echo "Setting Amphetamine preferences..."

defaults write com.if.Amphetamine "Start Session At Launch" -int 1
defaults write com.if.Amphetamine "Enable Session State Sound" -int 0
defaults write com.if.Amphetamine "Default Duration" -int 17

killall Amphetamine
open /Applications/Amphetamine.app