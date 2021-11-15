#!/bin/sh

###################################################################################
# PURPOSE - To unlink the Nessus agent , then re-link with a new Tenable instance #
###################################################################################

##########################################################
# Gathers the Nessus group and places it into a variable #
##########################################################
group=$(/Library/NessusAgent/run/sbin/nessuscli fix --secure --list | grep -io 'GROUP_VARIABLE' | tr -d ' ')

###########################################
# Unlinks, then re-links the Nessus Agent #
###########################################
/Library/NessusAgent/run/sbin/nessuscli agent unlink --force
sleep 5
/Library/NessusAgent/run/sbin/nessuscli agent link --key=<INSERT NESSUS KEY> --host=<INSERT NESSUS HOST> --port=<INSERT NESSUS PORT> --groups=$group

exit 0
