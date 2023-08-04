# Array of directories where the flags are saved
$directories = "C:\path\to\save\flags\user1", "C:\path\to\save\flags\user2", "C:\path\to\save\flags\user3"

# An array of user account names
$user_accounts = "user1", "user2", "user3"

# Check if snapshot number is provided
if ($args.Length -lt 1) {
    Write-Output "Please provide the snapshot number"
    exit
}

# Snapshot number taken from command line arguments
$snapshot_number = $args[0]

# Loop over each user account
for ($index = 0; $index -lt $user_accounts.Length; $index++) {
    # File path where the flag is stored
    $file_path = Join-Path $directories[$index] "flag_$($user_accounts[$index]).txt"

    # Check if the file exists
    if (Test-Path $file_path) {
        # Print a message with the snapshot number and file name
        Write-Output "Snapshot $snapshot_number file $file_path value is:"
        # Print the contents of the file
        Get-Content $file_path
        Write-Output ""
    } else {
        Write-Output "Snapshot $snapshot_number file $file_path does not exist."
    }
}
# Run the script with the following command:
# powershell.exe -ExecutionPolicy Bypass -File get_flag.ps1 <snapshot_number>