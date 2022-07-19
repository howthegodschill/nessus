#!/bin/sh

###############################################################################
# PURPOSE - Link Nessus Agent to the machine based on the selected group #
###############################################################################

# Installs the Nessus Agent from Jamf
/usr/local/jamf/bin/jamf policy -event <INSERT_JAMF_POLICY>

# Loads the agent
launchctl load -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

# Prompts for group selection
getGroup() {

theGroup=$(/usr/bin/osascript <<AppleScript

set myGroups to {"Admin", "Communications", "Developers", "Executive", "Finance", "IT", "Operations"}

set selectedGroup to {choose from list myGroups with prompt "Select the Group:"}

AppleScript

echo "${theGroup}"
)
}

getGroup

echo "${theGroup}"

# Selected group will kick off the link
case ${theGroup} in
    ${theGroup})
        sudo /Library/NessusAgent/run/sbin/nessuscli agent link --key=<INSERT_NESSUS_KEY> --host=<INSERT_NESSUS_HOST> --port=<INSERT_NESSUS_PORT> --groups=${theGroup};;
esac

exit 0
