#!/bin/bash
##=============================================================================
## Title:       discoverPi.sh
## Description: Used to discover Raspberry Pi's on your network
## Date:        2019-09-21
## Version:     See GitHub History
## Usage:       ./discoverPi.sh <network in CIDR format>
## Outputs:     Outputs a file with a list of IP addresses of Raspberry Pis
## Notes:       Example: ./discoverPi.sh 192.168.1.0/24
##              - Tested on MacOS
##              - Needs NMAP installed (brew install nmap)
##=============================================================================

## GLOBAL VARIABLES
##=============================================================================
# Accept all input to the script and store it
VAR_CIDR=$@

# Set a variable to the script name
VAR_SCRIPT_NAME="`basename $0`"

# Set a variable to the script location
VAR_SCRIPT_LOC="${PWD}"

# Set a variable to the output filename
FILE_OUTPUT="inventory.txt"

## MAIN
##=============================================================================
# Use NMAP to quickly discover raspberry pi's on the provided network
# via the first 24 bits of MAC addresses.
echo "Executing $VAR_SCRIPT_NAME" from "$VAR_SCRIPT_LOC"
sudo nmap -sP -n --scan-delay "1s" "$VAR_CIDR" | grep -B 2 "B8:27:EB" | \
grep -v "Host is up" | grep -v "\-\-" | grep -v "MAC" | cut -d ' ' -f5 | sudo tee -i -a "$FILE_OUTPUT" 

# Use sort with the unique flag to sort the list of IP's that is generated
# Previous NMAP outputs using 'tee' and the 'append' flag
# Use this to keep duplicates from registering in the output file
sudo sort -u -o $FILE_OUTPUT $FILE_OUTPUT

# Because we used sudo, you might get a permission error if you try to open 
# the file. Lets just use sudo to change the output file to easy mode 644
sudo chmod 644 "$FILE_OUTPUT"

## EXIT
##=============================================================================
# Forced exit with success. No logic here.
exit 0
