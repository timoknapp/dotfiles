osascript -e 'tell application "System Preferences" to quit'

echo "What's the name of this computer?"
read COMPUTER_NAME

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################
# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo scutil --set ComputerName "$COMPUTER_NAME"

# Show IP address, hostname, OS version when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Automatically switch appearance between Light and Dark
# This is usually set during initial setup but let's just be sure
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-US" "de-DE"
defaults write NSGlobalDomain AppleLocale -string "en_DE"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone (see `sudo systemsetup -listtimezones` for other values)
sudo systemsetup -settimezone "Europe/Berlin" > /dev/null

# Set standby delay to 24 hours (default is 1 hour)
#sudo pmset -a standbydelay 86400

# Disable Sudden Motion Sensor
#sudo pmset -a sms 0

# Change alert sound effect. All options can be reviewed here: /System/Library/Sounds
defaults write NSGlobalDomain com.apple.sound.beep.sound /System/Library/Sounds/Frog.aiff

# Disable audio feedback when volume is changed
defaults write com.apple.sound.beep.feedback -bool false

# Disable the sound effects on boot
#sudo nvram SystemAudioVolume=" "

# Menu bar: disable transparency
#defaults write com.apple.universalaccess reduceTransparency -bool true

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Menu bar: add volume item if it doesn't exist yet
# volume=$(grep "Volume.menu" ~/Library/Preferences/com.apple.systemuiserver.plist -c)
# if [ $volume = 0 ]; then
#     open '/System/Library/CoreServices/Menu Extras/Volume.menu'
# fi

# Disable opening and closing window animations
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to iCloud (not to disk) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
#defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Disable Notification Center and remove the menu bar icon
#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# Hide input menu in menu bar
defaults write com.apple.TextInputMenu visible -bool false

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Enable F-Keys instead of fn
defaults write NSGlobalDomain "com.apple.keyboard.fnState" -int 1

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Follow the keyboard focus while zoomed in
#defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###############################################################################
# Touchbar                                                            #
###############################################################################
echo -n "Change Touchbar"
defaults write com.apple.touchbar.agent 'PresentationModeFnModes = {functionKeys = app;};'
defaults write com.apple.touchbar.agent PresentationModeGlobal -string "functionKeys"
echo "  ✔" 


###############################################################################
# Keyboard shortcuts                                                          #
###############################################################################

# Set Spotlight shortuct to Command+Shift+Space
#defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{enabled = 1; value = { parameters = (32, 49, 1179648); type = 'standard'; }; }"

# Enable shortcuts to switch to spaces with Ctrl+Number
#defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 "{enabled = 1; value = { parameters = (65535, 18, 262144); type = 'standard'; }; }"
#defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 "{enabled = 1; value = { parameters = (65535, 19, 262144); type = 'standard'; }; }"
#defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 "{enabled = 1; value = { parameters = (65535, 20, 262144); type = 'standard'; }; }"

###############################################################################
# Trackpad, mouse, Bluetooth accessories                                      #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Trackpad: Increase tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3.0

# Trackpad: Haptic feedback
# 0: Light
# 1: Medium
# 2: Firm
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2

# Trackpad: Enable Force Click and haptic feedback
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true

# Trackpad: Enable silent clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

# Trackpad: swipe between pages with two fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

# Trackpad: Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Trackpad Scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -int 0

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Use scroll gesture with the Ctrl (^) modifier key to zoom
#defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
#defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

### TODO check com.apple.keyboard.modifiermapping

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
#defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: set default location for new windows
# Common options:
# - PfHm (Home)
# - PfDe (Desktop)
# - PfDo (Documents)
defaults write com.apple.finder NewWindowTarget PfHm

# Finder: set sidebar width
defaults write com.apple.finder SidebarWidth -int 180

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
#defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
#defaults write com.apple.frameworks.diskimages skip-verify -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Always open everything in Finder's column view.
# Use list view in all Finder windows by default
# Four-letter codes for all the view modes: `Nlsv`, `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Disable the warning before emptying the Trash
#defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

# todo add all faviorits like in osx 10.1 :-)


###############################################################################
# Mission Control                                                             #
###############################################################################

# Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

###############################################################################
# Dock                                                                        #
###############################################################################

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
#defaults write com.apple.dock launchanim -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# No bouncing icons
#defaults write com.apple.dock no-bouncing -bool true

# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-br-corner -int 0

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

###############################################################################
# Mail                                                                        #
###############################################################################

# Display emails in threaded mode
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"

# Disable send and reply animations in Mail.app
#defaults write com.apple.mail DisableReplyAnimations -bool true
#defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable automatic spell checking
#defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

# Disable sound for incoming mail
defaults write com.apple.mail MailSound -string ""

# Disable sound for other mail actions
#defaults write com.apple.mail PlayMailSounds -bool false

# Mark all messages as read when opening a conversation
#defaults write com.apple.mail ConversationViewMarkAllAsRead -bool true

# Disable includings results from trash in search
defaults write com.apple.mail IndexTrash -bool false

# Automatically check for new message (not every 5 minutes)
#defaults write com.apple.mail AutoFetch -bool true
#defaults write com.apple.mail PollTime -string "-1"

# Show most recent message at the top in conversations
defaults write com.apple.mail ConversationViewSortDescending -bool true

###############################################################################
# Calendar                                                                    #
###############################################################################

# Show week numbers (10.8 only)
defaults write com.apple.iCal "Show Week Numbers" -bool true

# Week starts on monday
defaults write com.apple.iCal "first day of week" -int 1

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some file types
#defaults write com.apple.spotlight orderedItems -array \
#	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
#	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
#	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
#	'{"enabled" = 1;"name" = "PDF";}' \
#	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
#	'{"enabled" = 1;"name" = "IMAGES";}' \
#	'{"enabled" = 1;"name" = "CONTACT";}' \
#	'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
#	'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
#	'{"enabled" = 0;"name" = "FONTS";}' \
#	'{"enabled" = 0;"name" = "MESSAGES";}' \
#	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
#	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
#	'{"enabled" = 0;"name" = "MUSIC";}' \
#	'{"enabled" = 0;"name" = "MOVIES";}' \
#	'{"enabled" = 0;"name" = "SOURCE";}'

# Load new settings before rebuilding the index
#killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
#sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
#sudo mdutil -E / > /dev/null

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Appearance
defaults write com.apple.terminal "Default Window Settings" -string "Homebrew"
defaults write com.apple.terminal "Startup Window Settings" -string "Homebrew"
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
#defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
#defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Software Updates                                                            #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Do not install macOS updates automatically
defaults write com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false

# Turn off app auto-update
#defaults write com.apple.commerce AutoUpdate -bool false

# Do not allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Address Book" "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "ControlStrip"; do
  killall "${app}" &> /dev/null
done