#!/bin/sh

is-executable dockutil || brew install dockutil

dockutil --no-restart --remove all

dockutil --no-restart --add "/Applications/Safari.app"
# dockutil --no-restart --add "/Applications/Firefox.app"
#dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Microsoft Edge.app"
dockutil --no-restart --add "/Applications/Enpass.app"
dockutil --no-restart --add "/Applications/Microsoft To Do.app/"
dockutil --no-restart --add "/Applications/Microsoft Outlook.app"
# dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Microsoft Teams.app"
# dockutil --no-restart --add "/Applications/IntelliJ IDEA.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
#dockutil --no-restart --add "/Applications/Spotify.app"
#dockutil --no-restart --add "/Applications/Slack.app"
#dockutil --no-restart --add "/Applications/Alacritty.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"

killall Dock
