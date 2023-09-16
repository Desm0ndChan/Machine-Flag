#!/bin/bash

# An array of user account names
user_accounts=("user1" "user2" "user3")
flag_names=("easy" "intermediate" "hard")
# Array of directories where to save the flags
directories=("/path/to/save/flags/user1" "/path/to/save/flags/user2" "/path/to/save/flags/user3")

# Server details
server="localhost"
port="80"

# snapshot number taken from command line arguments
machine="" # Change this
snapshot_number=$1

# Check if both arguments are provided
if [ -z "$machine" ] || [ -z "$snapshot_number" ]
then
  echo "Please provide both machine name and snapshot number"
  exit 1
fi

declare -A flags

# Loop to retrieve 3 flags for a given snapshot
for index in "${!user_accounts[@]}"
do
  # File path where the flag will be stored
  file_path="${directories[index]}/flag_${flag_names[index]}.txt"

  # Retrieve flag file using wget and save it to a specific directory, overwriting if it exists
  wget -qO $file_path "http://${server}:${port}/${machine}/Snapshot${snapshot_number}/flag_${flag_names[index]}.txt"
  
  # Store the flag in the associative array
  flags["${snapshot_number},${flag_names[index]}"]=$(cat "$file_path")

  # Change the permissions of the output file to 400
  chmod 400 $file_path
  # Change the owner and the group of the output file to the user account
  chown ${user_accounts[index]}:${user_accounts[index]} $file_path
  # Check if the file exists
  if [ -f "$file_path" ]; then
    # Print the permissions of the file
    echo "Permission of ${file_path}:"
    ls -la "$file_path"
    echo ""
  else
    echo "Snapshot ${snapshot_number} file ${file_path} does not exist."
  fi
done

# Print the table
echo -e "Snapshot\t${flag_names[0]}\t${flag_names[1]}\t${flag_names[2]}"
row="Snapshot $snapshot_number"
for flag_name in "${flag_names[@]}"
do
    row="${row}\t${flags["$snapshot_number,$flag_name"]}"
done
echo -e "$row"

# Run the script as follows: 
#./gc_flag.sh snapshot_number
