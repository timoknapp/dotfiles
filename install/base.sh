#!/bin/bash

# Check if script run on an m1 based mac
if [[ `uname -m` == 'arm64' ]]; then
    sudo softwareupdate --install-rosetta
fi