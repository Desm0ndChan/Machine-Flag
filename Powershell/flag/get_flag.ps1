# An array of user account names
$user_accounts = "user1", "user2", "user3"

# Array of directories where to save the flags
$directories = "C:\path\to\save\flags\user1", "C:\path\to\save\flags\user2", "C:\path\to\save\flags\user3"

# Server details
$server = "localhost"
$port = "8000"

# Check if both arguments are provided
if ($args.Length -lt 2) {
    Write-Output "Please provide both machine name and snapshot number"
    exit
}

# Machine name and snapshot number taken from command line arguments
$machine = $args[0]
$snapshot_number = $args[1]

# Loop to retrieve 3 flags for a given snapshot
for ($index = 0; $index -lt $user_accounts.Length; $index++) {
    # File path where the flag will be stored
    $file_path = Join-Path $directories[$index] "flag_$($user_accounts[$index]).txt"

    # Retrieve flag file using Invoke-WebRequest and save it to a specific directory, overwriting if it exists
    Invoke-WebRequest -Uri "http://$server:$port/$machine/Snapshot$snapshot_number/flag_$($user_accounts[$index]).txt" -OutFile $file_path

    # Change the permissions of the output file to Read-Only (Equivalent to 400 in Unix)
    $acl = Get-Acl $file_path
    $acl.SetAccessRuleProtection($True, $False)
    Set-Acl -Path $file_path -AclObject $acl

    # Change the owner and the group of the output file to the user account
    # No direct equivalent in PowerShell, but it can be done using .NET methods.
    $user = New-Object System.Security.Principal.NTAccount($user_accounts[$index])
    $acl.SetOwner($user)
    $acl.SetGroup($user)
    Set-Acl -Path $file_path -AclObject $acl
}
# Run the script with the following command:
# powershell.exe -ExecutionPolicy Bypass -File get_flag.ps1 <machine_name> <snapshot_number>