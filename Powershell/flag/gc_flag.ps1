# An array of user account names
$user_accounts = "user1", "user2", "user3"
$flag_names = "easy", "intermediate", "hard"
# Array of directories where to save the flags
$directories = "C:\", "C:\", "C:\"

# Server details
$server = "localhost"
$port = "80"

# Machine name and snapshot number taken from command line arguments
$machine = ""
$snapshot_number = $args[0]

# Check if snapshot number is provided
if ([string]::IsNullOrWhiteSpace($snapshot_number)) {
  Write-Host "Please provide the snapshot number"
  exit 1
}

$flags = @{}

# Loop to retrieve 3 flags for a given snapshot
for ($i = 0; $i -lt $user_accounts.Length; $i++) {
  # File path where the flag will be stored
  $file_path = Join-Path -Path $directories[$i] -ChildPath ("flag_" + $flag_names[$i] + ".txt")

  # Retrieve flag file using Invoke-WebRequest and save it to a specific directory, overwriting if it exists
  Invoke-WebRequest -Uri "http://$server`:$port/$machine/Snapshot$snapshot_number/flag_$($flag_names[$i]).txt" -OutFile $file_path -ErrorAction SilentlyContinue
  
  # Change the permissions of the output file
  $acl = Get-Acl -Path $file_path

  # Grant Read permission to the original user
  $userAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user_accounts[$i], "Read", "Allow")
  $acl.SetAccessRule($userAccessRule)

  # Apply the updated ACL to the file
  Set-Acl -Path $file_path -AclObject $acl

  # Check if the file exists
  if (Test-Path -Path $file_path) {
    # Store flag value in hashtable for later printing
    $flags[$flag_names[$i]] = Get-Content -Path $file_path
    
    # Print the permissions of the file
    Write-Host "Permissions of $file_path: "
    icacls.exe $file_path
    Write-Host "" # Empty line for clarity
  } else {
    Write-Host "Snapshot $snapshot_number file $file_path does not exist."
  }
}

# Print the table
Write-Host ""
Write-Host ("Snapshot " + $snapshot_number + "`t" + ($flag_names -join "`t"))

$row = "Snapshot $snapshot_number"
foreach ($flag_name in $flag_names) {
  $row += "`t" + $flags[$flag_name]
}
Write-Host $row
