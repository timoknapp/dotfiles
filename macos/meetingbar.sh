#!/bin/sh

echo "Setting MeetingBar preferences..."

defaults write leits.MeetingBar launchAtLogin -int 1
defaults write leits.MeetingBar shortenEventTitle -int 1
defaults write leits.MeetingBar menuEventTitleLength -int 45
defaults write leits.MeetingBar statusbarEventTitleLength -int 10
defaults write leits.MeetingBar eventTitleIconFormat -string "\"ms_teams_icon\""
defaults write leits.MeetingBar eventTitleFormat -string "\"show\""
defaults write leits.MeetingBar eventTimeFormat -string "\"show\""
defaults write leits.MeetingBar showEventMaxTimeUntilEventThreshold -int 120

killall MeetingBar
open /Applications/MeetingBar.app