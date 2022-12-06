#!/bin/sh

# Not using official dockutil version, since it does not support Python3 (https://github.com/kcrawford/dockutil/issues/127)
is-executable dockutil || brew install --cask hpedrorodrigues/tools/dockutil

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
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications" --view grid --display folder --sort name

killall Dock
