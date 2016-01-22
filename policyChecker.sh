#!/bin/bash

#Variables do not need to be modified.

loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
receipt="/Library/Application Support/JAMF/receipts/"
packageName="$4"

# ===========

if [ "$4" == "" ]; then
    echo "Package was not defined. Define the package before running the policy again."
    exit 1
fi

if [ -e "$receipt$4" ]; then
    echo "Package, $4, was installed, submitting inventory."
    /usr/local/jamf/bin/jamf recon
    exit 0
else
    echo "Package, $4, was not installed. The policy will try again later."
    exit 1
fi
