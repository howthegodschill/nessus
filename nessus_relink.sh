#!/bin/sh

####################################################
# PURPOSE - To unlink then relink the Nessus agent #
####################################################

# Gathers the Nessus group and places it into a variable
group=$(/Library/NessusAgent/run/sbin/nessuscli fix --secure --list | grep -io 'GROUP_VARIABLE' | tr -d ' ')

# Unlinks the Nessus Agent
/Library/NessusAgent/run/sbin/nessuscli agent unlink --force

sleep 5

# Links the Nessus Agent to the proper group in the Tenable instance
/Library/NessusAgent/run/sbin/nessuscli agent link \
--key=<INSERT_NESSUS_KEY> \
--host=<INSERT_NESSUS_HOST> \
--port=<INSERT_NESSUS_PORT> \
--groups=$group

exit 0
