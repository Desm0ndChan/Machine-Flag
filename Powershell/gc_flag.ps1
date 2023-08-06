# An array of user account names
$user_accounts = "user1", "user2", "user3" #change this

# Array of directories where to save the flags
$directories = "C:\", "C:\", "C:\" #change this

# Server details
$server = "localhost"#change this
$port = "80"

# Machine name and snapshot number taken from command line arguments
$machine = "" #change this
$snapshot_number = $args[1]

# Check if both arguments are provided
if ([string]::IsNullOrWhiteSpace($machine) -or [string]::IsNullOrWhiteSpace($snapshot_number)) {
  Write-Host "Please provide both machine name and snapshot number"
  exit 1
}

# Loop to retrieve 3 flags for a given snapshot
for ($i = 0; $i -lt $user_accounts.Length; $i++) {
  # File path where the flag will be stored
  $file_path = Join-Path -Path $directories[$i] -ChildPath ("flag_" + $user_accounts[$i] + ".txt")

  # Retrieve flag file using Invoke-WebRequest and save it to a specific directory, overwriting if it exists
  Invoke-WebRequest -Uri "http://$server`:$port/$machine/Snapshot$snapshot_number/flag_$($user_accounts[$i]).txt" -OutFile $file_path -ErrorAction SilentlyContinue

  # Change the permissions of the output file
  $acl = Get-Acl -Path $file_path

  # Grant Read permission to the original user
  $userAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user_accounts[$i], "Read", "Allow")
  $acl.AddAccessRule($userAccessRule)

  # Grant Read permission to Administrator
  $adminAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator", "Read", "Allow")
  $acl.AddAccessRule($adminAccessRule)

  # Grant Read permission to System
  $systemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("System", "Read", "Allow")
  $acl.AddAccessRule($systemAccessRule)

  # Apply the updated ACL to the file
  Set-Acl -Path $file_path -AclObject $acl
  
  # Check if the file exists
  if (Test-Path -Path $file_path) {
    # Print a message with the snapshot number and file name
    Write-Host "Snapshot $snapshot_number file $file_path value is:"
    # Print the permissions of the file
    Write-Host "Permissions: $(Get-Acl -Path $file_path)"
    # Print the contents of the file
    Get-Content -Path $file_path
    Write-Host ""
  } else {
    Write-Host "Snapshot $snapshot_number file $file_path does not exist."
  }
}
