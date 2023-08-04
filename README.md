# Introduction
This repository contains scripts that used for setting up pentration testing practice machines

# Linux
## flag_create.sh
Execute this script to create all the flags in a main server(not vulnerable machine),
one execution will be able to create 10 snapshots' flags
one for enumeration, one for initial foothold, one for priv esc.
Start a http server for flag files transfer.

## get_flag.sh
Use this script to retrieve flag files from main server.

## check_flag.sh
Use this script to check corresponding flag file content to see 
if flag retrival is working as expected

# Windows
## get_flag.ps1
Same usage as get_flag.sh

## check_flag.ps1
Same usage as check_flag.sh

## add_user.ps1
Create users based on users.txt.
Add user to corresponding groups based on rdp.txt and winrm.txt

## DC_config.ps1
Configure a windows server 2019 with AD and DNS features.
enabled zone transfer with any server, 
added a txt record and multiple subdomain for zone transfer.

## disable_all.ps1
Disabling all security features in a windows server.