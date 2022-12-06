#!/bin/sh

echo "Setting Spotify preferences..."

defaults write com.spotify.client AutoStartSettingIsHidden -int 0

killall Spotify