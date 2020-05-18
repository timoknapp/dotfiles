#!/bin/sh

defaults write com.knollsoft.Rectangle gapSize -float 10
defaults write com.knollsoft.Rectangle almostMaximizeHeight -float .98
defaults write com.knollsoft.Rectangle almostMaximizeWidth -float .98

killall Rectangle