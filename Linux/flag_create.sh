#!/bin/bash

# An array of user account names
flag_names=("easy" "intermediate" "hard")

# Machine names
machine="MACHINE_NAME"

# Create directory for the machine
mkdir -p "${machine}"

# Loop to create 10 snapshots for each machine
for (( i=1; i<=10; i++ ))
do
# Create directory SnapshotX
    mkdir -p "${machine}/Snapshot${i}"

    # Loop to create 3 flags in each snapshot
    for flag_name in "${flag_names[@]}"
    do
        # Generate flag
        flag=$(echo ${RANDOM} | md5sum | head -c 25)
        # Create flag file
        echo Snapshot ${i} flag for ${flag_name} is ${flag}
        echo ${flag} > "${machine}/Snapshot${i}/flag_${flag_name}.txt"
    done
done