# Check if the script is running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to run this script as an Administrator!"
    Exit
}

# Import usernames from the users.txt file
$userList = Get-Content "C:\path\to\users.txt"

# Loop through the list of users and add each user
foreach ($user in $userList) {
    # Create user without password
    New-LocalUser -Name $user -NoPassword -UserMayNotChangePassword -PasswordNeverExpires
}

# Import usernames from the rdp.txt file
$rdpUserList = Get-Content "C:\path\to\rdp.txt"

# Loop through the list of rdp users and add each user to the Remote Desktop Users group
foreach ($user in $rdpUserList) {
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member $user
}

# Import usernames from the winrm.txt file
$winrmUserList = Get-Content "C:\path\to\winrm.txt"

# Loop through the list of winrm users and add each user to the Remote Management Users group
foreach ($user in $winrmUserList) {
    Add-LocalGroupMember -Group "Remote Management Users" -Member $user
}
