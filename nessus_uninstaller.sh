#!/bin/sh

#####################################################
# PURPOSE - Unlink and remove Nessus from a machine #
#####################################################

# Unlinks the Nessus Agent
sudo /Library/NessusAgent/run/sbin/nessuscli agent unlink --force

# Stops the the Agent from running
launchctl unload -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

# Removes and disables the Agent service
rm -r /Library/NessusAgent
rm -r /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist
rm -r /Library/PreferencePanes/Nessus\ Agent\ Preferences.prefPane
sudo launchctl remove com.tenablesecurity.nessusagent

exit 0
