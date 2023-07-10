#!/bin/bash

# An array of user account names
user_accounts=("user1" "user2" "user3")

# Machine names
machine="MACHINE_NAME"

# Create directory for the machine
mkdir "${machine}"

# Loop to create 10 snapshots for each machine
for (( i=1; i<=10; i++ ))
do
# Create directory SnapshotX
    mkdir "${machine}/Snapshot${i}"

    # Loop to create 3 flags in each snapshot
    for user_account in "${user_accounts[@]}"
    do
        # Generate flag
        flag=$(echo ${RANDOM} | md5sum | head -c 25)
        # Create flag file
        echo Snapshot ${i} flag for ${user_account} is ${flag}
        echo ${flag} > "${machine}/Snapshot${i}/flag_${user_account}.txt"
    done
done