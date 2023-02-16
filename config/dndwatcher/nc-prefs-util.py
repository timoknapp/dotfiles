#!/usr/bin/env python3
"""Read/Modify NotificationCenter Preferences."""
import argparse
import logging
import plistlib
from os.path import expanduser

logging.basicConfig()
_LOGGER = logging.getLogger(__name__)
#_LOGGER.setLevel(logging.DEBUG)

DEFAULTS_DOMAIN = "com.apple.ncprefs"
DOTFILES_CONFIG = "~/.dotfiles/config/dndwatcher/{}.plist"
USER_PREFS = "~/Library/Preferences/{}.plist"
SYSTEM_CENTER = "_SYSTEM_CENTER_"

BUNDLE_IDS = ['com.microsoft.teams', 'com.microsoft.Outlook']

# flags are bits in a 16 bit(?) data structure
DONT_SHOW_IN_CENTER = 1 << 0
BADGE_ICONS = 1 << 1
SOUNDS = 1 << 2
BANNER_STYLE = 1 << 3
ALERT_STYLE = 1 << 4
UNKNOWN_5 = 1 << 5
UNKNOWN_6 = 1 << 6
UNKNOWN_7 = 1 << 7
UNKNOWN_8 = 1 << 8
UNKNOWN_9 = 1 << 9
UNKNOWN_10 = 1 << 10
UNKNOWN_11 = 1 << 11
SUPPRESS_NOTIFICATIONS_ON_LOCKSCREEN = 1 << 12
SHOW_PREVIEWS_ALWAYS = 1 << 13
SUPPRESS_MESSAGE_PREVIEWS = 1 << 14
UNKNOWN_15 = 1 << 15

class NotificationSettings(object):
    """Represent Notification Settings."""

    def __init__(self, flags):
        """Initialize object."""
        _LOGGER.debug("Flags: {}".format(flags))
        self.flags = flags

    def get_flag(self, shift):
        """Return True/False depending on shift."""
        # return False if self.flags & shift else True
        # print("get_flag: {}/{}".format(self.flags, shift))
        if self.flags & shift:
            return True
        else:
            return False

    def set_flag(self, flag, shift):
        """Set Flag to True."""
        _LOGGER.debug("set_flag: {}/{}".format(flag, shift))
        _LOGGER.debug("Flags before: {}".format(self.flags))
        if flag:  # enable
            self.flags |= shift
        else:  # disable
            self.flags &= ~(shift)
        _LOGGER.debug("Flags after: {}".format(self.flags))

    @property
    def show_on_lockscreen(self):
        """Return show_on_lockscreen setting."""
        return self.get_flag(SUPPRESS_NOTIFICATIONS_ON_LOCKSCREEN)

    @property
    def badge_app_icon(self):
        """Return badge_app_icon setting."""
        return self.get_flag(BADGE_ICONS)

    @show_on_lockscreen.setter
    def show_on_lockscreen(self, flag):
        self.set_flag(flag, SUPPRESS_NOTIFICATIONS_ON_LOCKSCREEN)

    @badge_app_icon.setter
    def badge_app_icon(self, flag):
        self.set_flag(flag, BADGE_ICONS)


def without_keys(d, keys):
    """Return dict without keys."""
    return {k: v for k, v in d.items() if k not in keys}


def main():
    """Provide main routine."""
    parser = argparse.ArgumentParser(description='MacOS Notification Center Util.')
    parser.add_argument("--enable", action="store_true", help="Enable Notifications (If not provided it is False)")
    parser.add_argument('--disable', dest='enable', action='store_false', help="Disbale Notifications (It is always False if not provided)")
    parser.set_defaults(enable=False)
    args = parser.parse_args()
    notifications_enabled = args.enable
    _LOGGER.debug("Enable notifications: {}".format(notifications_enabled))

    with open(expanduser(USER_PREFS.format(DEFAULTS_DOMAIN)), "rb") as plist:
        data = plistlib.load(plist)

    new_data = without_keys(data, "apps")
    new_data["apps"] = []
    has_changes = False

    for app in data["apps"]:
        # ignore System's applications
        # if not app["bundle-id"].startswith(SYSTEM_CENTER):
        if app["bundle-id"] in BUNDLE_IDS:
            _LOGGER.debug("bundle-id: {}".format(app["bundle-id"]))
            app_prefs = NotificationSettings(app.get("flags", 0))

            _LOGGER.debug("badge_app_icon: {}".format(app_prefs.get_flag(BADGE_ICONS)))

            # if app_prefs.show_on_lockscreen:
            #     has_changes = True
            #     # print("Change for: {}".format(app["bundle-id"]))
            #     app_prefs.show_on_lockscreen = False

            if notifications_enabled:
                has_changes = True
                # _LOGGER.debug("Change for: {}".format(app["bundle-id"]))
                app_prefs.badge_app_icon = True
            else:
                has_changes = True
                # _LOGGER.debug("Change for: {}".format(app["bundle-id"]))
                app_prefs.badge_app_icon = False

            app["flags"] = app_prefs.flags
        new_data["apps"].append(app)

    if has_changes:
        with open(expanduser(DOTFILES_CONFIG.format(DEFAULTS_DOMAIN)), "wb") as plist:
            plistlib.dump(new_data, plist)

        # print(
        #     "\nImport new preferences with:\n"
        #     "\tdefaults import com.apple.ncprefs - < {}\n\n"
        #     "Finally execute to reload:\n"
        #     "\tkillall NotificationCenter && killall usernoted".format(
        #         expanduser(DOTFILES_CONFIG
        #     .format(DEFAULTS_DOMAIN))
        #     )
        # )
    else:
        print("No changes - all good")


if __name__ == "__main__":
    main()
