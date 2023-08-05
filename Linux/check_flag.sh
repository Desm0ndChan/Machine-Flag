#!/bin/bash

# Array of directories where the flags are saved
directories=("/path/to/save/flags/user1" "/path/to/save/flags/user2" "/path/to/save/flags/user3")

# An array of user account names
user_accounts=("user1" "user2" "user3")

# Snapshot number taken from command line arguments
snapshot_number=$1

# Check if snapshot number is provided
if [ -z "$snapshot_number" ]
then
  echo "Please provide the snapshot number"
  exit 1
fi

# Loop over each user account
for index in "${!user_accounts[@]}"
do
  # File path where the flag is stored
  file_path="${directories[index]}/flag_${user_accounts[index]}.txt"

  # Check if the file exists
  if [ -f "$file_path" ]; then
    # Print a message with the snapshot number and file name
    echo "Snapshot ${snapshot_number} file ${file_path} value is:"
    # Print the permissions of the file
    echo "Permissions: $(stat -c "%A" "$file_path")"
    # Print the contents of the file
    cat "$file_path"
    echo ""
  else
    echo "Snapshot ${snapshot_number} file ${file_path} does not exist."
  fi
done
# run the script as follows:
# ./check_flag.sh snapshot_number