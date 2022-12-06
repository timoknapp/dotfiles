#!/bin/sh

echo "Setting Amphetamine preferences..."

defaults write com.if.Amphetamine "Start Session At Launch" -int 1

killall Amphetamine
open /Applications/Amphetamine.app