#!/bin/bash

# An array of user account names
user_accounts=("user1" "user2" "user3")

# Array of directories where to save the flags
directories=("/path/to/save/flags/user1" "/path/to/save/flags/user2" "/path/to/save/flags/user3")

# Server details
server="localhost"
port="8000"

# Machine name and snapshot number taken from command line arguments
machine=$1
snapshot_number=$2

# Check if both arguments are provided
if [ -z "$machine" ] || [ -z "$snapshot_number" ]
then
  echo "Please provide both machine name and snapshot number"
  exit 1
fi

# Loop to retrieve 3 flags for a given snapshot
for index in "${!user_accounts[@]}"
do
  # File path where the flag will be stored
  file_path="${directories[index]}/flag_${user_accounts[index]}.txt"

  # Retrieve flag file using wget and save it to a specific directory, overwriting if it exists
  wget -O $file_path "http://${server}:${port}/${machine}/Snapshot${snapshot_number}/flag_${user_accounts[index]}.txt"
  
  # Change the permissions of the output file to 400
  chmod 400 $file_path
  # Change the owner and the group of the output file to the user account
  chown ${user_accounts[index]}:${user_accounts[index]} $file_path

done
# Run the script as follows: 
#./get_flag.sh machine_name snapshot_number