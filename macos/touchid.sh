#!/bin/sh

echo "Setting Touch ID preferences..."

# Update /etc/pam.d/sudo to allow Touch ID: https://azimi.io/how-to-enable-touch-id-for-sudo-on-macbook-pro-46272ac3e2df
SUDO_FILE=/etc/pam.d/sudo
if grep -q "pam_tid.so" "$SUDO_FILE"; then
  echo "Touch ID is already setup for running sudo commands."
else
  awk 'NR==2 {print "auth       sufficient     pam_tid.so"} 1' $SUDO_FILE > tmp && sudo mv tmp $SUDO_FILE
fi