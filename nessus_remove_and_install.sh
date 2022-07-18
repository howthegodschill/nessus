#!/bin/sh

#########################################################
# PURPOSE - Remove The Nessus Agent, Then Re-Install It #
#########################################################

# Gathers the Nessus group and places it into a variable
group=$(/Library/NessusAgent/run/sbin/nessuscli fix --secure --list | grep -io 'GROUP_VARIABLE' | tr -d ' ')

# Unlinks the Nessus Agent
/Library/NessusAgent/run/sbin/nessuscli agent unlink --force

# Stops the the Agent from running
launchctl unload -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

# Removes and disables the Agent service
rm -r /Library/NessusAgent
rm -r /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist
rm -r /Library/PreferencePanes/Nessus\ Agent\ Preferences.prefPane
launchctl remove com.tenablesecurity.nessusagent

sleep 10

# Installs the Nessus Agent from Jamf
/usr/local/jamf/bin/jamf policy -event <INSERT_JAMF_POLICY>

# Loads the agent
launchctl load -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

# Links the Nessus Agent to the proper department in the Tenable instance
/Library/NessusAgent/run/sbin/nessuscli agent link \
--key=<INSERT_NESSUS_KEY> \
--host=<INSERT_NESSUS_HOST> \
--port=<INSERT_NESSUS_PORT> \
--groups=$group

exit 0
