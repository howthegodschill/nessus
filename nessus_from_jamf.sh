#!/bin/sh

##############################################
# This script will do the following:         #
# 1. Gather the assigned department in Jamf  #
# 2. Link to Tenable based on the department #
##############################################

# Installs the Nessus Agent from Jamf
/usr/local/jamf/bin/jamf policy -event <INSERT_JAMF_POLICY>

# Loads the agent
launchctl load -w /Library/LaunchDaemons/com.tenablesecurity.nessusagent.plist

# Jamf Pro Server URL
jss_url=$(defaults read /Library/Preferences/com.jamfsoftware.jamf.plist jss_url \
| sed s'/.$//')

# API User and Password are stored and defined in the jamf pro server
# in the script parameters $4 and $5
api_user="$4"
api_pass="$5"

# Get the serial number of the mac running this script.
serial_number=$(system_profiler SPHardwareDataType \
| awk '/Serial Number/{print $4}')

# Use the API to get the assigned Department
department=$(curl -su "$api_user":"$api_pass" -H "Accept: application/xml" "$jss_url"/JSSResource/computers/serialnumber/"$serial_number" \
| xmllint --xpath 'computer/location/department/text()' -)

# Links the Nessus Agent to the proper department in the Tenable instance
/Library/NessusAgent/run/sbin/nessuscli agent link \
--key=<INSERT_NESSUS_KEY> \
--host=<INSERT_NESSUS_HOST> \
--port=<INSERT_NESSUS_PORT> \
--groups=$department

exit 0
