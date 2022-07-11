#!/bin/sh

###############################################################################
# PURPOSE - Link Nessus Agent to the machine based on the selected department #
###############################################################################

#######################################
# Installs the Nessus Agent from Jamf #
#######################################
/usr/local/jamf/bin/jamf policy -event install-nessus
launchctl load -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

####################################
# Prompts for department selection #
####################################
getDepartment() {

theDepartment=$(/usr/bin/osascript <<AppleScript

set myDepartments to {"Admin", "Communications", "Developers", "Executive", "Finance", "IT", "Operations"}

set selectedDepartment to {choose from list myDepartments with prompt "Select the Department:"}

AppleScript

echo "${theDepartment}"
)
}

getDepartment

echo "${theDepartment}"

##############################################
# Selected department will kick off the link #
##############################################
case ${theDepartment} in
    ${theDepartment})
        sudo /Library/NessusAgent/run/sbin/nessuscli agent link --key=<INSERT_NESSUS_KEY> --host=<INSERT_NESSUS_HOST> --port=<INSERT_NESSUS_PORT> --groups=${theDepartment};;
esac

exit 0
